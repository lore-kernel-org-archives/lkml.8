Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50DAC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6D021734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="vN9o+Q3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgBMQFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:05:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34035 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388260AbgBMQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:05:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id j4so3346378pgi.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Nw7URh+UMCPI53aY8KronYHaSIRJakz2tA+QVeHRq24=;
        b=vN9o+Q3ylXls7dbXZf7pb/BIPUAI8Rq7Vvzs+fg7G1A1zZ0N40p1LKY63k5fzF8dE/
         SUM+YiJ9jqaU/EER7RCFRbv+4s5Dl+QygoZOI0MFB4v6UYZ09sSYMuLr0IWHzE/o1FPm
         8oK92WL0KjzSl4FX/VGKfQ58yvvzeV/A0n6ChZ9Pf48ydntQl2k3DZ7/ffrpC2IJUEJb
         f1ec9bn9QARh8hezJM8WiEBIvFtcYq7OIdfUvK2JDNR2ZwV0+QUDK8XqMNwZWlTpBzGR
         edXS6d7DKgctWboMSFvd3oIPwmZeo+q81rh28UocbZhWsx+6w5ryC1WhQgKKqTZ7i/78
         hU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Nw7URh+UMCPI53aY8KronYHaSIRJakz2tA+QVeHRq24=;
        b=oVHWscS63MbjVV2C0/FWOItsyG67pXb5+dEML5XtPrVqRvkQl3u0OzaWEwPgVEzLWZ
         2gBZHsjzpHArUQgE88/keqHvKzo0Y0YcbkPVjM7z4PFmqSqUzdwGf0IBARkVB5/2BzUA
         YVE2RKyGnzx2xXY8Q5KZkNHay/XZkmSqVI9pNNsBqPXU/fu0FdpCTDDNZWkDttrnX84Z
         mgCxAg19+aikwHptz4VUhqyhP2ax/Zd6frTZzeXrYk12TXJhcQHbl4Ysyu6QVgsJixYC
         1P2/ylsJUGsSXdLtKJaHM5UCKR9gh+8j1W6GR4QtSV2sZd+lHzOBfL+rzLP6AIEvTLpo
         5bUQ==
X-Gm-Message-State: APjAAAX0x6Eo+L4TCyDQUroNeIcWRGkY+r4u22tEfR3A9O6efdMNaaJB
        PFN5P3MHm2Sr2RKOtDjK5DV5KFb0LZQ=
X-Google-Smtp-Source: APXvYqwoar8rBWSpiup3MdH7P5BbX7a3Za05ctuYjG7lmMKzNxPXx+gxROipIcVYQPWoBdY6rSms4w==
X-Received: by 2002:a62:b60b:: with SMTP id j11mr14757776pff.255.1581609911677;
        Thu, 13 Feb 2020 08:05:11 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:4e4:2fae:ba85:17b7? ([2601:646:c200:1ef2:4e4:2fae:ba85:17b7])
        by smtp.gmail.com with ESMTPSA id 70sm3544667pgd.28.2020.02.13.08.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 08:05:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 0/5] New way to track mce notifier chain actions
Date:   Thu, 13 Feb 2020 08:05:09 -0800
Message-Id: <A5D5C146-DA47-46F3-ACE1-2D3FCCFA1FDD@amacapital.net>
References: <20200213060949.GA31799@zn.tnic>
Cc:     "Luck, Tony" <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200213060949.GA31799@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 12, 2020, at 10:09 PM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFOn Wed, Feb 12, 2020 at 09:52:39PM -0800, Andy Lutomirski wrote:
>> I HATE notifier chains for exceptions, and I REALLY HATE NOTIFY_STOP.
>> I don't suppose we could rig something up so that they are simply
>> notifiers (for MCE and, eventually, for everything) and just outright
>> prevent them from modifying the processing?
>=20
> As in: they all get executed unconditionally and there's no NOTIFY_STOP
> and if they're not interested in the notification, they simply return
> early?
>=20
> Hohumm, sounds nicer.
>=20

Exactly :)

> --=20
> Regards/Gruss,
>    Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette
