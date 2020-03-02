Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B973CC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B35521739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCBKaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:30:04 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:33524 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726874AbgCBKaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:30:04 -0500
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 022AU2Ob021054
        for <linux-kernel@vger.kernel.org>; Mon, 2 Mar 2020 05:30:02 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 022ATvCL018786
        for <linux-kernel@vger.kernel.org>; Mon, 2 Mar 2020 05:30:02 -0500
Received: by mail-qt1-f197.google.com with SMTP id i25so588434qtm.17
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 02:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=/VcLffZUTgvTWC8ZFO3N6mDeTTtIIDh0TAgvcx3iXEw=;
        b=mICqQddg3iDL2n0siUN2iHpZwz87eT/1bSIjf9PEVof/9H0FG1aI4+K9hH63uuDcW0
         H1mCZ1eVjzlVQB+lsb4MHM0viDkBuv7IeBDx8JN6JOlc5m9EK1dPS4UiBgn8VYua2xqJ
         yHWkZiBN2Xa10UldS3m/mcnafbAxwelI5z4J7HhrMNPodSicLs5uAXDOe5Z9RfMmb/gk
         EhpV/yNEEffUfqvXKBbHFug8p8IW4QmADzquOzq8xaJ6/BhgwKKRfJ9XJOecTCBlhZ52
         XDx1XsWfkb/48dkxnnY/WWMqr5vJhI/uOja3AKp3EHsOq7YxaGgK0X46oO4wBBktAMh+
         bxDw==
X-Gm-Message-State: APjAAAWP5SIJX4pivYmtQi+z+wTJK48noURpkvPo8hrCItAB72LX0CMP
        t7MN/Z+/2xmBd+znyvwKmc7mPw5oh9YKXpdpA8fAzA3bIoFo+h4dmscJjCoXMGXLfp5vQcwt7Vn
        sa3jNXy0QggXwsCAMzYCL5Ff6v0cqXdYUcaU=
X-Received: by 2002:a37:4e53:: with SMTP id c80mr14345727qkb.58.1583144996947;
        Mon, 02 Mar 2020 02:29:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBh6WXMWHNRoxL92FxaSm7tZWkWljn+/lubfFhH1jeDvkVwJTYHB9DmVs0hkAFcj5IVD9Bog==
X-Received: by 2002:a37:4e53:: with SMTP id c80mr14345713qkb.58.1583144996622;
        Mon, 02 Mar 2020 02:29:56 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id j17sm10248504qth.27.2020.03.02.02.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 02:29:54 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: exfat: clean up d_entry rebuilding.
In-Reply-To: <20200302095716.64155-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
References: <20200302095716.64155-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1583144993_2391P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Mar 2020 05:29:54 -0500
Message-ID: <240472.1583144994@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1583144993_2391P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Mar 2020 18:57:15 +0900, Tetsuhiro Kohada said:
> Clean up d_entry rebuilding in exfat_rename_file() and move_file().
>
> -Replace memcpy of d_entry with structure copy.

Those look OK.

> -Change to use the value already stored in fid.

> -		if (exfat_get_entry_type(epnew) == TYPE_FILE) {

> +		if (fid->type == TYPE_FILE) {

Are you sure this is OK to do? exfat_get_entry_type() does a lot of
mapping between values, using a file_dentry_t->type, while
fid->type is a file_id_t->type. and at first read it's not obvious to me whether
fid->type is guaranteed to have the correct value already.

(The abundant use of 0xNN constants in exfat_get_entry_type()  doesn't
inspire confidence that it's looking at what you think it's looking at...)



--==_Exmh_1583144993_2391P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXlzgIQdmEQWDXROgAQI58g/8DOieHjL/SZ7yeem2t4q7TX4M9CzzWBEA
gCgEpSqWrxEfRPn4OfLS/S6CMQtDPrdv8mDqvmNIRa0S27G+kvvCdOVbIYDnDIHD
uqUmHKhPoUdTH+6k4XXErNBO4hG0NlpFAAVEpyY0x3Yo8zK5a6kW9NroYknqHq0g
/zafLt+WTiwU4InxRznidC4UvQ9Dvi9hMUnEzziYuR/E11ruzpQjfc8gcCkRawh0
F2bgfjwXhAFdyXGhkJdcfeNjXRMgFUPy4a0fVK32uxSo3kfYJYX0cSzSspkCoZm2
bIWbR0pg/Lx/AjH1V5JiTK+EQixeC0ujAXmbzGVT2H16cWSMqnFbmVVjRgSBY0fI
Y/N8HHyLxUx5u87b6B97wvNZiExkDID38Br05uFuOIasOMOMs3fE3mpJ7/J/FRFd
dUXKZJ6+wni8X4kZVHTleUuZVtQK0hSTZBj3wOL7prAn9uJiCP3b7t6MdfCOegV6
VcKJyhLvu6LmByPunjU75UTTmWj3dMGYdYDFEDD+jfHBXMh0AX54rHwy4jO0BwU2
/X+YrqpbOWL8C7+1E//vJq00X+CNyNG98iJ1QJWJV7EOUrUTnnLUa11+DLc9CUtB
R6r7VF469EJ7MfZG8L0keg5eLSNUQL2H9I8FU1id0xrHxJ7HQtH9lz6Dav1+Bnj4
bOOVWDTwOt8=
=DpqH
-----END PGP SIGNATURE-----

--==_Exmh_1583144993_2391P--
