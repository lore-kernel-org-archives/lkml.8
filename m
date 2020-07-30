Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88B4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC77B20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gRCrpeiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgG3ShM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbgG3ShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:37:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:37:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d1so14947225plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NIuEhN3QVwcexUX1pun+ZO7pJkR7rOvAqahdBOBhmQo=;
        b=gRCrpeiTXjwKCvcmoCX1hv/Xw5Pt0yrCYzbzY1mNOI7K4H27iuPoQDx41OlyL7OJgb
         esyOpOSCt71O3/6B/gglPm6k8hInovF3cJdFJhi8dr9IUUoc3QM1yutoc3ZYuhFaVQPL
         KB9xtk1JUOeVc1+d/oS8lAJhBzQH8s+Jsmei0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NIuEhN3QVwcexUX1pun+ZO7pJkR7rOvAqahdBOBhmQo=;
        b=Jft2+DbHD5XfzZGA2g9TpExYSvP1IsuUBegBNzzqb54zpOaWXSuxQ5MjTUHksC/a8V
         5GJ6WnjA/k6Lepv68msTYo2QpezXWzOg4lkW7GT8y8+pyISpvaQ8BicSnj3bJfX8UYrI
         xw85vdNavVuM03+9RYRjzZ7kL24ZeH7f9vt6eC5o34arnn/2YG+95IguKRLsK/c5Jr8b
         ION8mVioR86O4nmSnDewrnWGctpcw/ybdfn0czAtXCl4mlccJVX0ErzLZqG4wSXuZcwW
         7OnI+id9pIwW1fH0LAAjUKchc7/m32v10hAMloz4MFZCb5Zz5Mh/EMv02dFcmFJh724F
         DUvQ==
X-Gm-Message-State: AOAM530I4UXfouVfMG88q8ToSSiw8LDJK/VG0kW4a9MP1aQqwuJis8Wt
        BfKz39fahEjWulTi2ZIlCEyZHg==
X-Google-Smtp-Source: ABdhPJwes0N/97QIES9EQw1iX9qfDiLuc00ZfdqAKmMmNK+uo4ZPFMhqhOS5ExiBochXcOdFojGAiA==
X-Received: by 2002:a17:90b:46c1:: with SMTP id jx1mr443429pjb.125.1596134226902;
        Thu, 30 Jul 2020 11:37:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13sm7074282pfq.220.2020.07.30.11.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 11:37:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mailmap: Restore dictionary sorting
Date:   Thu, 30 Jul 2020 11:37:01 -0700
Message-Id: <20200730183702.702552-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730183702.702552-1-keescook@chromium.org>
References: <20200730183702.702552-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several names had been recently appended (instead of inserted). Sort the
entire file (which includes some minor shuffling for dictionary order).

Done with the following commands:

	grep -E '^(#|$)' .mailmap > .mailmap.head
	grep -Ev '^(#|$)' .mailmap > .mailmap.body
 	sort -f .mailmap.body > .mailmap.body.sort
	cat .mailmap.head .mailmap.body.sort > .mailmap
	rm .mailmap.head .mailmap.body.sort

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .mailmap | 110 +++++++++++++++++++++++++++----------------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/.mailmap b/.mailmap
index c69d9c734fb5..4e6c169719df 100644
--- a/.mailmap
+++ b/.mailmap
@@ -10,27 +10,27 @@
 Aaron Durbin <adurbin@google.com>
 Adam Oldham <oldhamca@gmail.com>
 Adam Radford <aradford@gmail.com>
-Adrian Bunk <bunk@stusta.de>
 Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
+Adrian Bunk <bunk@stusta.de>
 Alan Cox <alan@lxorguk.ukuu.org.uk>
 Alan Cox <root@hraefn.swansea.linux.org.uk>
-Aleksey Gorelov <aleksey_gorelov@phoenix.com>
 Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.com>
-Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@intel.com>
-Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@linaro.org>
+Aleksey Gorelov <aleksey_gorelov@phoenix.com>
 Alexandre Belloni <alexandre.belloni@bootlin.com> <alexandre.belloni@free-electrons.com>
-Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
 Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
 Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
+Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
+Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@intel.com>
+Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@linaro.org>
 Al Viro <viro@ftp.linux.org.uk>
 Al Viro <viro@zenIV.linux.org.uk>
 Andi Shyti <andi@etezian.org> <andi.shyti@samsung.com>
 Andreas Herrmann <aherrman@de.ibm.com>
-Andrey Ryabinin <ryabinin.a.a@gmail.com> <a.ryabinin@samsung.com>
 Andrew Morton <akpm@linux-foundation.org>
-Andrew Murray <amurray@thegoodpenguin.co.uk> <andrew.murray@arm.com>
 Andrew Murray <amurray@thegoodpenguin.co.uk> <amurray@embedded-bits.co.uk>
+Andrew Murray <amurray@thegoodpenguin.co.uk> <andrew.murray@arm.com>
 Andrew Vasquez <andrew.vasquez@qlogic.com>
+Andrey Ryabinin <ryabinin.a.a@gmail.com> <a.ryabinin@samsung.com>
 Andy Adamson <andros@citi.umich.edu>
 Antoine Tenart <antoine.tenart@free-electrons.com>
 Antonio Ospite <ao2@ao2.it> <ao2@amarulasolutions.com>
@@ -40,40 +40,42 @@ Arnaud Patard <arnaud.patard@rtp-net.org>
 Arnd Bergmann <arnd@arndb.de>
 Axel Dyks <xl@xlsigned.net>
 Axel Lin <axel.lin@gmail.com>
-Bart Van Assche <bvanassche@acm.org> <bart.vanassche@wdc.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
+Bart Van Assche <bvanassche@acm.org> <bart.vanassche@wdc.com>
 Ben Gardner <bgardner@wabtec.com>
 Ben M Cahill <ben.m.cahill@intel.com>
 Björn Steinbrink <B.Steinbrink@gmx.de>
-Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
-Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Boris Brezillon <bbrezillon@kernel.org> <b.brezillon.dev@gmail.com>
 Boris Brezillon <bbrezillon@kernel.org> <b.brezillon@overkiz.com>
+Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
+Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Brian Avery <b.avery@hp.com>
 Brian King <brking@us.ibm.com>
+Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
+Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
 Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>
 Chao Yu <chao@kernel.org> <yuchao0@huawei.com>
-Christoph Hellwig <hch@lst.de>
 Christophe Ricard <christophe.ricard@gmail.com>
+Christoph Hellwig <hch@lst.de>
 Corey Minyard <minyard@acm.org>
 Damian Hobson-Garcia <dhobsong@igel.co.jp>
-Daniel Borkmann <daniel@iogearbox.net> <dborkman@redhat.com>
-Daniel Borkmann <daniel@iogearbox.net> <dborkmann@redhat.com>
+Daniel Borkmann <daniel@iogearbox.net> <danborkmann@googlemail.com>
 Daniel Borkmann <daniel@iogearbox.net> <danborkmann@iogearbox.net>
 Daniel Borkmann <daniel@iogearbox.net> <daniel.borkmann@tik.ee.ethz.ch>
-Daniel Borkmann <daniel@iogearbox.net> <danborkmann@googlemail.com>
+Daniel Borkmann <daniel@iogearbox.net> <dborkmann@redhat.com>
+Daniel Borkmann <daniel@iogearbox.net> <dborkman@redhat.com>
 Daniel Borkmann <daniel@iogearbox.net> <dxchgb@gmail.com>
 David Brownell <david-b@pacbell.net>
 David Woodhouse <dwmw2@shinybook.infradead.org>
-Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@mips.com>
-Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@imgtec.com>
 Dengcheng Zhu <dzhu@wavecomp.com> <dczhu@mips.com>
 Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@gmail.com>
+Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@imgtec.com>
+Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@mips.com>
 <dev.kurt@vandijck-laurijssen.be> <kurt.van.dijck@eia.be>
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
-Dmitry Safonov <0x7f454c46@gmail.com> <dsafonov@virtuozzo.com>
-Dmitry Safonov <0x7f454c46@gmail.com> <d.safonov@partner.samsung.com>
 Dmitry Safonov <0x7f454c46@gmail.com> <dima@arista.com>
+Dmitry Safonov <0x7f454c46@gmail.com> <d.safonov@partner.samsung.com>
+Dmitry Safonov <0x7f454c46@gmail.com> <dsafonov@virtuozzo.com>
 Domen Puncer <domen@coderock.org>
 Douglas Gilbert <dougg@torque.net>
 Ed L. Cashin <ecashin@coraid.com>
@@ -84,9 +86,9 @@ Felix Kuhling <fxkuehl@gmx.de>
 Felix Moeller <felix@derklecks.de>
 Filipe Lautert <filipe@icewall.org>
 Franck Bui-Huu <vagabon.xyz@gmail.com>
-Frank Rowand <frowand.list@gmail.com> <frowand@mvista.com>
 Frank Rowand <frowand.list@gmail.com> <frank.rowand@am.sony.com>
 Frank Rowand <frowand.list@gmail.com> <frank.rowand@sonymobile.com>
+Frank Rowand <frowand.list@gmail.com> <frowand@mvista.com>
 Frank Zago <fzago@systemfabricworks.com>
 Gao Xiang <xiang@kernel.org> <gaoxiang25@huawei.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@aol.com>
@@ -94,6 +96,8 @@ Greg Kroah-Hartman <greg@echidna.(none)>
 Greg Kroah-Hartman <gregkh@suse.de>
 Greg Kroah-Hartman <greg@kroah.com>
 Gregory CLEMENT <gregory.clement@bootlin.com> <gregory.clement@free-electrons.com>
+Gustavo Padovan <gustavo@las.ic.unicamp.br>
+Gustavo Padovan <padovan@profusion.mobi>
 Hanjun Guo <guohanjun@huawei.com> <hanjun.guo@linaro.org>
 Henk Vergonet <Henk.Vergonet@gmail.com>
 Henrik Kretzschmar <henne@nachtwindheim.de>
@@ -101,32 +105,32 @@ Henrik Rydberg <rydberg@bitmath.org>
 Herbert Xu <herbert@gondor.apana.org.au>
 Jacob Shin <Jacob.Shin@amd.com>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
-Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@motorola.com>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk.kim@samsung.com>
+Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@motorola.com>
 Jakub Kicinski <kuba@kernel.org> <jakub.kicinski@netronome.com>
 James Bottomley <jejb@mulgrave.(none)>
 James Bottomley <jejb@titanic.il.steeleye.com>
 James E Wilson <wilson@specifix.com>
-James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 James Hogan <jhogan@kernel.org> <james@albanarts.com>
+James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 James Ketrenos <jketreno@io.(none)>
 Jan Glauber <jan.glauber@gmail.com> <jang@de.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jang@linux.vnet.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jglauber@cavium.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
-Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
 <javier@osg.samsung.com> <javier.martinez@collabora.co.uk>
+Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
 Jayachandran C <c.jayachandran@gmail.com> <jayachandranc@netlogicmicro.com>
 Jayachandran C <c.jayachandran@gmail.com> <jchandra@broadcom.com>
 Jayachandran C <c.jayachandran@gmail.com> <jchandra@digeo.com>
 Jayachandran C <c.jayachandran@gmail.com> <jnair@caviumnetworks.com>
-Jean Tourrilhes <jt@hpl.hp.com>
 <jean-philippe@linaro.org> <jean-philippe.brucker@arm.com>
+Jean Tourrilhes <jt@hpl.hp.com>
 Jeff Garzik <jgarzik@pretzel.yyz.us>
-Jeff Layton <jlayton@kernel.org> <jlayton@redhat.com>
 Jeff Layton <jlayton@kernel.org> <jlayton@poochiereds.net>
 Jeff Layton <jlayton@kernel.org> <jlayton@primarydata.com>
+Jeff Layton <jlayton@kernel.org> <jlayton@redhat.com>
 Jens Axboe <axboe@suse.de>
 Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
 Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
@@ -147,27 +151,27 @@ Kay Sievers <kay.sievers@vrfy.org>
 Kenneth W Chen <kenneth.w.chen@intel.com>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
 Koushik <raghavendra.koushik@neterion.com>
-Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
+Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
-Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
-Leon Romanovsky <leon@kernel.org> <leonro@mellanox.com>
 Leonardo Bras <leobras.c@gmail.com> <leonardo@linux.ibm.com>
 Leonid I Ananiev <leonid.i.ananiev@intel.com>
+Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
+Leon Romanovsky <leon@kernel.org> <leonro@mellanox.com>
 Linas Vepstas <linas@austin.ibm.com>
-Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
-Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
 Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
+Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
 Lukasz Luba <lukasz.luba@arm.com> <l.luba@partner.samsung.com>
 Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
-Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
 Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
+Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
 Mark Brown <broonie@sirena.org.uk>
 Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
-Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
+Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Mathieu Othacehe <m.othacehe@gmail.com>
 Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
 Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
@@ -177,17 +181,17 @@ Matthew Wilcox <willy@infradead.org> <willy@debian.org>
 Matthew Wilcox <willy@infradead.org> <willy@linux.intel.com>
 Matthew Wilcox <willy@infradead.org> <willy@parisc-linux.org>
 Matthieu CASTET <castet.matthieu@free.fr>
-Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@brturbo.com.br>
+Matt Ranostay <matt.ranostay@konsulko.com> <matt@ranostay.consulting>
+Matt Ranostay <mranostay@gmail.com> Matthew Ranostay <mranostay@embeddedalley.com>
+Matt Ranostay <mranostay@gmail.com> <matt.ranostay@intel.com>
+Matt Redfearn <matt.redfearn@mips.com> <matt.redfearn@imgtec.com>
 Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com>
+Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@brturbo.com.br>
 Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@infradead.org>
+Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@osg.samsung.com>
 Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@redhat.com>
 Mauro Carvalho Chehab <mchehab@kernel.org> <m.chehab@samsung.com>
-Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@osg.samsung.com>
 Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@s-opensource.com>
-Matt Ranostay <mranostay@gmail.com> Matthew Ranostay <mranostay@embeddedalley.com>
-Matt Ranostay <mranostay@gmail.com> <matt.ranostay@intel.com>
-Matt Ranostay <matt.ranostay@konsulko.com> <matt@ranostay.consulting>
-Matt Redfearn <matt.redfearn@mips.com> <matt.redfearn@imgtec.com>
 Maxime Ripard <mripard@kernel.org> <maxime.ripard@bootlin.com>
 Maxime Ripard <mripard@kernel.org> <maxime.ripard@free-electrons.com>
 Mayuresh Janorkar <mayur@ti.com>
@@ -216,13 +220,13 @@ Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
 Patrick Mochel <mochel@digitalimplant.org>
 Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
+Paul E. McKenney <paulmck@kernel.org> <paul.mckenney@linaro.org>
 Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.ibm.com>
 Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.vnet.ibm.com>
-Paul E. McKenney <paulmck@kernel.org> <paul.mckenney@linaro.org>
 Paul E. McKenney <paulmck@kernel.org> <paulmck@us.ibm.com>
 Peter A Jonsson <pj@ludd.ltu.se>
-Peter Oruba <peter@oruba.de>
 Peter Oruba <peter.oruba@amd.com>
+Peter Oruba <peter@oruba.de>
 Pratyush Anand <pratyush.anand@gmail.com> <pratyush.anand@st.com>
 Praveen BP <praveenbp@ti.com>
 Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
@@ -235,23 +239,23 @@ Ralf Baechle <ralf@linux-mips.org>
 Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
 Randy Dunlap <rdunlap@infradead.org> <rdunlap@xenotime.net>
 Rémi Denis-Courmont <rdenis@simphalempin.com>
-Ricardo Ribalda <ribalda@kernel.org> <ricardo.ribalda@gmail.com>
 Ricardo Ribalda <ribalda@kernel.org> <ricardo@ribalda.com>
 Ricardo Ribalda <ribalda@kernel.org> Ricardo Ribalda Delgado <ribalda@kernel.org>
+Ricardo Ribalda <ribalda@kernel.org> <ricardo.ribalda@gmail.com>
 Ross Zwisler <zwisler@kernel.org> <ross.zwisler@linux.intel.com>
 Rudolf Marek <R.Marek@sh.cvut.cz>
 Rui Saraiva <rmps@joel.ist.utl.pt>
 Sachin P Sant <ssant@in.ibm.com>
-Sarangdhar Joshi <spjoshi@codeaurora.org>
+Sakari Ailus <sakari.ailus@linux.intel.com> <sakari.ailus@iki.fi>
 Sam Ravnborg <sam@mars.ravnborg.org>
-Santosh Shilimkar <ssantosh@kernel.org>
 Santosh Shilimkar <santosh.shilimkar@oracle.org>
+Santosh Shilimkar <ssantosh@kernel.org>
+Sarangdhar Joshi <spjoshi@codeaurora.org>
 Sascha Hauer <s.hauer@pengutronix.de>
 S.Çağlar Onur <caglar@pardus.org.tr>
-Sakari Ailus <sakari.ailus@linux.intel.com> <sakari.ailus@iki.fi>
 Sean Nyekjaer <sean@geanix.com> <sean.nyekjaer@prevas.dk>
-Sebastian Reichel <sre@kernel.org> <sre@debian.org>
 Sebastian Reichel <sre@kernel.org> <sebastian.reichel@collabora.co.uk>
+Sebastian Reichel <sre@kernel.org> <sre@debian.org>
 Sedat Dilek <sedat.dilek@gmail.com> <sedat.dilek@credativ.de>
 Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>
 Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>
@@ -262,18 +266,21 @@ Simon Arlott <simon@octiron.net> <simon@fire.lp0.eu>
 Simon Kelley <simon@thekelleys.org.uk>
 Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <shemminger@osdl.org>
+Steve Wise <larrystevenwise@gmail.com> <swise@chelsio.com>
+Steve Wise <larrystevenwise@gmail.com> <swise@opengridcomputing.com>
 Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
 Subhash Jadavani <subhashj@codeaurora.org>
 Sudeep Holla <sudeep.holla@arm.com> Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
 Sumit Semwal <sumit.semwal@ti.com>
+Takashi YOSHII <takashi.yoshii.zj@renesas.com>
 Tejun Heo <htejun@gmail.com>
 Thomas Graf <tgraf@suug.ch>
 Thomas Pedersen <twp@codeaurora.org>
 Tiezhu Yang <yangtiezhu@loongson.cn> <kernelpatch@126.com>
 Todor Tomov <todor.too@gmail.com> <todor.tomov@linaro.org>
 Tony Luck <tony.luck@intel.com>
-TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
 TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
+TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
 Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
 Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
 Uwe Kleine-König <ukl@pengutronix.de>
@@ -282,22 +289,15 @@ Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@intel.com>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@linux.intel.com>
 Vinod Koul <vkoul@kernel.org> <vkoul@infradead.org>
+Viresh Kumar <vireshk@kernel.org> <viresh.kumar2@arm.com>
 Viresh Kumar <vireshk@kernel.org> <viresh.kumar@st.com>
 Viresh Kumar <vireshk@kernel.org> <viresh.linux@gmail.com>
-Viresh Kumar <vireshk@kernel.org> <viresh.kumar2@arm.com>
 Vivien Didelot <vivien.didelot@gmail.com> <vivien.didelot@savoirfairelinux.com>
 Vlad Dogaru <ddvlad@gmail.com> <vlad.dogaru@intel.com>
-Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@virtuozzo.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@parallels.com>
-Takashi YOSHII <takashi.yoshii.zj@renesas.com>
+Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@virtuozzo.com>
 Will Deacon <will@kernel.org> <will.deacon@arm.com>
-Wolfram Sang <wsa@kernel.org> <wsa@the-dreams.de>
 Wolfram Sang <wsa@kernel.org> <w.sang@pengutronix.de>
+Wolfram Sang <wsa@kernel.org> <wsa@the-dreams.de>
 Yakir Yang <kuankuan.y@gmail.com> <ykk@rock-chips.com>
 Yusuke Goda <goda.yusuke@renesas.com>
-Gustavo Padovan <gustavo@las.ic.unicamp.br>
-Gustavo Padovan <padovan@profusion.mobi>
-Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
-Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
-Steve Wise <larrystevenwise@gmail.com> <swise@chelsio.com>
-Steve Wise <larrystevenwise@gmail.com> <swise@opengridcomputing.com>
-- 
2.25.1

