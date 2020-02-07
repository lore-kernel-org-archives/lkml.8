Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF1C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BC22082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs8xRFTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgBGGmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:42:15 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46223 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgBGGmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:42:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id g64so1102202otb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 22:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nS5JPWneySiodQp4hbvudj9hL13ty2+PLssqsVAS96w=;
        b=Vs8xRFTrFsZE+EsSeCBIS2SL2f3chCCp8q53YEs384RGhmJyR25P2g1CveTLhp+fQg
         4YqpqJxKR3akAHbk38yJBQi7gRysih+h5j9CVYCFcCy7Z2AQtOoaJqxMIkT9Vi4bwJX1
         ZULLciChr57C6Yr4X2mqzTXrrwKj1tYhY/ADWz3ljJ3emjYTFa51ndT1oevSdaAlBTRc
         ObcLLuahG2SyQpYCPeIRv6sxUDF7wPlSEwZDKSLgnTiND+jPzhpg0qHCI7fttrPpc/Nx
         F35SCGsNLUZG43xmMpe6w4U3aPkHWvXa+hdcOo2gJhw1Qpzsfekyefja1knccBOZ3MH4
         b1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nS5JPWneySiodQp4hbvudj9hL13ty2+PLssqsVAS96w=;
        b=KjFqSA5NgEpQwkOYoxdlUxITdNXy2/Qsfr+N2PYC7eNJcfBK7K1cM9FxHR/xggZnXv
         iDStfKW/+YuTOlMmavuccIw9pz8VIi3RxJEdGEBZswG5DNdDxQ4DuFJ48LT6vx4j20Kf
         nWQ7vmAr1PoKHg4s3FYW/Gfw6ttmNa9os05LATGCRc4CmZARRS68aarSu6N9W7Ab77m5
         BbEb1eSEOAfBFpdu+GN1bJmL54COsF22yxvKIr6hlvVK3LqMr10RixZQxHjqljK7ilxW
         jqw3rbMPyY3vLgYKk3ELwHEvyn+7UCOdcR+1wLwiiRXnbZ7JU+KVfuy6itWETebCmyKM
         gQOg==
X-Gm-Message-State: APjAAAVAK5Op+wVNGQWBvttyx2T9aAXOX2yr4nV0zWUd2XWRPG081ZwH
        o2mzRJjv1wFrtkgQj6JU2fI=
X-Google-Smtp-Source: APXvYqxY08dp4nEVmXY+bzQpTc9NeccNUwPT87+k4AMkhnYV8ZH2K7XLvmf5ma93LqZCe823DQW28w==
X-Received: by 2002:a05:6830:12c3:: with SMTP id a3mr1569040otq.341.1581057732875;
        Thu, 06 Feb 2020 22:42:12 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id z21sm777102oto.52.2020.02.06.22.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 22:42:12 -0800 (PST)
Date:   Thu, 6 Feb 2020 23:42:10 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Fangrui Song <maskray@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] powerpc/vdso32: mark __kernel_datapage_offset as
 STV_PROTECTED
Message-ID: <20200207064210.GA13125@ubuntu-x2-xlarge-x86>
References: <20200205005054.k72fuikf6rwrgfe4@google.com>
 <10e3d362-ec29-3816-88ff-8415d5c78e3b@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10e3d362-ec29-3816-88ff-8415d5c78e3b@c-s.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 07:25:59AM +0100, Christophe Leroy wrote:
> 
> 
> Le 05/02/2020 à 01:50, Fangrui Song a écrit :
> > A PC-relative relocation (R_PPC_REL16_LO in this case) referencing a
> > preemptible symbol in a -shared link is not allowed.  GNU ld's powerpc
> > port is permissive and allows it [1], but lld will report an error after
> > https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=ec0895f08f99515194e9fcfe1338becf6f759d38
> 
> Note that there is a series whose first two patches aim at dropping
> __kernel_datapage_offset . See
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=156045 and
> especially patches https://patchwork.ozlabs.org/patch/1231467/ and
> https://patchwork.ozlabs.org/patch/1231461/
> 
> Those patches can be applied independentely of the rest.
> 
> Christophe

If that is the case, it would be nice if those could be fast tracked to
5.6 because as it stands now, all PowerPC builds that were working with
ld.lld are now broken. Either that or take this patch and rebase that
series on this one.

Cheers,
Nathan
