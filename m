Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCBDC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 03:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A052073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 03:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="qOIuXMr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgBLDsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:48:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41605 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgBLDsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:48:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so467580pgf.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 19:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=6n20LY7Gbk1vIJ9y2Ek0mCSqczMDBuYCkKoruXym20c=;
        b=qOIuXMr7r5BjTTN+iUHHZHwXO2d7fltI4qfqf6tbvQdh49e6cPRYEmcbGwuGAudwb8
         w30L9oHSj79cz2PbPcfqcB0XK5ilmwynVKV5aJeHITXsOfGQ2xUe9v8aFSP2LLudhaqZ
         5EuvCyJJGJ3MGeULZocj6JU8fEJyVtrln/UygU9d8PPqtZxL46O0XGUSRS+39CSaFCaR
         PhuepTAcAYHA+JKjnq+oXEayOFQCah3uurRAwCjTvqdoLYAUh8wSQQCctFOTihvo8swD
         tQpwBaUvnbY54Av/9UrQQY8UAW1JwMUpiJdvP7Al5IAKyacPUWPBhZ8RkUJSh68erc9A
         ehOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6n20LY7Gbk1vIJ9y2Ek0mCSqczMDBuYCkKoruXym20c=;
        b=jts2s5rCR2YzJ9kfPXxVFzD7jZOai3sb2vryETA5h5MRlyURUEijZ1q7ZWQ2c42Ozr
         XNt0OImWeO0/QKdEMstmmxNTzigTpRd8t4oHECZ2eM8Dwh+n21UYcUZU9LzkD/KWxGZv
         VL7fGU8MQCB9NOVxVqYVh6UJCN6gcv8xGIkQK6M1Rnz/cywJWs8z0CV1uoLLoJ+wfJi0
         QN9JRyw8omHj+YJ/mWn2AWY8XhIF2D42h9IjlN/4Nkor8HDiDrrGT0U47SPV3fHA6s6E
         JM7pJ1ayT5kNX+7LWTbp3cJrFDk9CQs+X19FXjHmFRQu4Mk4dduZvZPyU+TEoEUA+x6K
         4a5g==
X-Gm-Message-State: APjAAAXwbM6TB5l5um7POzUH/I3jieg1E6WiCanmEaNjvPefMr8YTD14
        VhPEP4I7WtxFxVPxmhxG7AOmnE7DErY=
X-Google-Smtp-Source: APXvYqwHXdDGCoJF29xdQdH8f5hJD2lx/3SlqjjMPooqFIPhLc6mldJbeBq8PCoMMtLk5e0pp0EI6A==
X-Received: by 2002:a63:f20a:: with SMTP id v10mr10098705pgh.420.1581479295020;
        Tue, 11 Feb 2020 19:48:15 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:d1cf:7a62:c997:6a4b? ([2601:646:c200:1ef2:d1cf:7a62:c997:6a4b])
        by smtp.gmail.com with ESMTPSA id 72sm6294836pfw.7.2020.02.11.19.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 19:48:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 00/62] Linux as SEV-ES Guest Support
Date:   Tue, 11 Feb 2020 19:48:12 -0800
Message-Id: <BD48E405-8E3F-4EEE-A72A-8A7EDCB6A376@amacapital.net>
References: <20200211135256.24617-1-joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <JGross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 11, 2020, at 5:53 AM, Joerg Roedel <joro@8bytes.org> wrote:

>=20
>=20
>    * Putting some NMI-load on the guest will make it crash usually
>      within a minute

Suppose you do CPUID or some MMIO and get #VC. You fill in the GHCB to ask f=
or help. Some time between when you start filling it out and when you do VMG=
EXIT, you get NMI. If the NMI does
its own GHCB access [0], it will clobber the outer #VC=E2=80=99a state, resu=
lting in a failure when VMGEXIT happens. There=E2=80=99s a related failure m=
ode if the NMI is after the VMGEXIT but before the result is read.

I suspect you can fix this by saving the GHCB at the beginning of do_nmi and=
 restoring it at the end. This has the major caveat that it will not work if=
 do_nmi comes from user mode and schedules, but I don=E2=80=99t believe this=
 can happen.

[0] Due to the NMI_COMPLETE catastrophe, there is a 100% chance that this ha=
ppens.=
