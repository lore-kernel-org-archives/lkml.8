Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6A3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25A425466
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CEIoTrFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbgFVH2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731406AbgFVH2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:28:12 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77053C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:28:11 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h23so4800819qtr.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=+Uan9/0g2Kyk0+JFE+Gg6CPXTL0iWc6TM1qX4k9tCCI=;
        b=CEIoTrFcH9/ZEoLTpd6fmSkXQV5kJx6SiBea4C6+IwoO8z+Z1TfY40M/x2iObM6GCX
         Jy0tips3m8ok7iClqxkfuII3htkyFo2IDfNlN9BJlPhADjGd4YdrnLMXw4ktOca61LUM
         RgCJBX3fDwyzBWJfd0ozcaqZ6YmVWeYWWSAO3lq1tlxxaoTRw/zU38Dp0DN404aTxwyv
         2/LqaODnfkrI2Swvw8Goi9ZK+IAOUU1I/ISmwsOvUqZHpiTgD1Sh3Ynja398PQfCSD8T
         x/QO1WjXLd1y8S85tUcQSR8LZeMki8SEWYs+lZdo7Dp8DrHB218NllVMmIRo8KfQ7AwQ
         oOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+Uan9/0g2Kyk0+JFE+Gg6CPXTL0iWc6TM1qX4k9tCCI=;
        b=lkW+pdNTUTH/QhNmsAY/ShyZq/KWDtJ5GvXBjLlUvFLgAkC1VR/N91O0DLMRvrwlXL
         Xfae/Mr+w4qH4DC+SDrN95KOAQiJ1ZCACBDB2qPdUJ5geIj8HL09Mypjbx95zvjGqGVy
         y/a4kxjR0Npln4QzaFMlz9lbzjA0MDMAwKZtYlrF7H/uHy+fqz8she+AF2q5wg9SBLDS
         orx8pjTDh3PMTyDPBOkxoqQcJldFuSGvpNEzPecHQhoGMel+kLib4rtdz82JFzavoNhf
         XoyW7AHBRQ1HrxKWcfil4Th+ogZNTVuaVyP1sUTZiR2WI+SYLoVl9If//MuigViiUDXC
         WYAg==
X-Gm-Message-State: AOAM530c9AH9LRlEkfTXs64USzeCKBmUpb0u9nTBR7t9o1aUi4aN7YOG
        4H09gnXkqWdpVebTRc5raEQdaw==
X-Google-Smtp-Source: ABdhPJyWb4e97Z2/IMIqh2GpP+NVHRpesI9AkxGHkQn4/h3yxibqRZAvS1qnEvwYKJTYlHnAvtsp5w==
X-Received: by 2002:ac8:5307:: with SMTP id t7mr15073070qtn.229.1592810890652;
        Mon, 22 Jun 2020 00:28:10 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k20sm14406128qtu.16.2020.06.22.00.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 00:28:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: linux-next boot error: WARNING in kmem_cache_free
Date:   Mon, 22 Jun 2020 03:28:09 -0400
Message-Id: <121C0D57-C9E6-406B-A280-A67E773EA9D0@lca.pw>
References: <CACT4Y+ZcbA=9L2XPC_rRG-FdwOoH6XteOoGHg7jfvd+1CH2M+w@mail.gmail.com>
Cc:     syzbot <syzbot+95bccd805a4aa06a4b0d@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
In-Reply-To: <CACT4Y+ZcbA=9L2XPC_rRG-FdwOoH6XteOoGHg7jfvd+1CH2M+w@mail.gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 22, 2020, at 2:42 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>=20
> There is a reason, it's still important for us.
> But also it's not our strategy to deal with bugs by not testing
> configurations and closing eyes on bugs, right? If it's an official
> config in the kernel, it needs to be tested. If SLAB is in the state
> that we don't care about any bugs in it, then we need to drop it. It
> will automatically remove it from all testing systems out there. Or at
> least make it "depends on BROKEN" to slowly phase it out during
> several releases.

Do you mind sharing what=E2=80=99s your use cases with CONFIG_SLAB? The only=
 thing prevents it from being purged early is that it might perform better w=
ith a certain type of networking workloads where syzbot should have nothing t=
o gain from it.

I am more of thinking about the testing coverage that we could use for syzbo=
t to test SLUB instead of SLAB. Also, I have no objection for syzbot to test=
 SLAB, but then from my experience, you are probably on your own to debug fu=
rther with those testing failures. Until you are able to figure out the bugg=
y patch or patchset introduced the regression, I am afraid not many people w=
ould be able to spend much time on SLAB. The developers are pretty much alre=
ady half-hearted on it by only fixing SLAB here and there without runtime te=
sting it.=
