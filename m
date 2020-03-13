Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57744C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F82020724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pajlEWhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgCMR6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:58:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38004 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgCMR6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:58:04 -0400
Received: by mail-oi1-f194.google.com with SMTP id k21so10329989oij.5;
        Fri, 13 Mar 2020 10:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIpHicZ3t9iIlvAbQDoq7yMgDqITyaH5TIJrz/BqXnM=;
        b=pajlEWhQvJv7jUlPghiKengiEw+LA672a3zHZyhTIOIHNd9fbK7F02v7SZS7Nd/Yve
         wtvsHNiX3lOcQn+dJ716JHkKLfoznlfBDDbeIhxP0mWrbijWm495IPRMOQiT9e4w/O8K
         FoNMZhdEgNALYCPWXluzZo/AN7pMYm61cEta/Sn93JLSZ+Y0Yiat2z2sQDalnTpHdDNB
         atMJwbAPz/9RzSGLNGFx4ukFpNnR5a4Pvn6sf9PSTT6jFV+cbEfcNfz2VUd2ryytvo3p
         3E/NuSx+rIPqfe/9kP+K4kA6kveUAkUbP2Q09Lr8qUMLHTlNN7dLFAbFmWDIz4B2GCCy
         saMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIpHicZ3t9iIlvAbQDoq7yMgDqITyaH5TIJrz/BqXnM=;
        b=ZGLec1gsFLlUi7SynTdRDmPOMIv9gihN1pPs/F09PoHcyWoWfeRQaXzihHtJ+shh+h
         /V9hYl0GBWBEI97+HucFEj1NQ+4fFJPmnnafLldrUY5tJyO9bxxVtb3oiz1e3b9pP0wF
         BnyFtu7SswfnOxB6iFdL/4hHf20s0lq/zfQcq0T9HAVRTVv/4X0Y9H5Uf/dQXR1v0KEu
         80bnVI51FBrMja+5xax9FlWJCa5ScO35n1OnkUS+ajqKFe8Oeyg2UU4pLuyMUQ/PhRuL
         GxINqt9EZDFj0yKOXB+sgrKoSMyjUxSBFQLyx3cVxLBrKXg4e2c03t312wH+ImGisNil
         qnRw==
X-Gm-Message-State: ANhLgQ0h0cPVhGeOCOPLgRG8nqQzjConudNQOtExjBruU0mpAlBSGwSn
        3jlDhQOlyEPl21H8Jp/KbvX8EJD/3HZkUmS4eew=
X-Google-Smtp-Source: ADFU+vtEY7euvss/M7JNwQVhcGKtmxZ40FX07jehyrWbEISEBbbCApK8W2f0qsKVuiT238XrGK1YqqP9yLq4nUKVpPs=
X-Received: by 2002:a05:6808:b24:: with SMTP id t4mr8115642oij.72.1584122283944;
 Fri, 13 Mar 2020 10:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000061573105a08774c2@google.com>
In-Reply-To: <00000000000061573105a08774c2@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 13 Mar 2020 10:57:52 -0700
Message-ID: <CAM_iQpUBL=P6xvnyZckwVPUnmxReFDXJpfTA-ZtMqeAnh-4XVA@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in route4_change
To:     syzbot <syzbot+f9b32aaacd60305d9687@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/congwang/linux.git tcindex
