Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95385C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F7420724
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9jCrMcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgCWDZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 23:25:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33206 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgCWDZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 23:25:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id g18so5331680plq.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 20:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=W5/HuYT04J9xFWoRJUWPWZDvQ+RTTmITj2K9cIZHjQ4=;
        b=t9jCrMcP9XGXrPYPNO++uUbfhAJMTloAyKe15C/EaCXF/NZH/TG7805BGWiIUC42Xa
         5rqLpaZzEetvDbYwNcKx4dH2combp4m9Hog6K98lQ7Y+MlzyJBZR0swKz43Wkqyyug6b
         gXTUoYtzlhNZRzt1up3vQzsTpiB451iNb9QIuf6l1a+0xnF68rjgz6GA3W4Vbjs+NxYP
         S658Yc1152OlnQH6qv2JQr712YjBHBHe9RksbdA2qAHpKV5HHvHd5hsUNguGXmy9u3X0
         +b22BQKBNiwKmiZsFmRP9qH5lu8VGfCT3INyQzkHl65a/G9kB21rGLkucC1p8c9bnxr4
         vJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=W5/HuYT04J9xFWoRJUWPWZDvQ+RTTmITj2K9cIZHjQ4=;
        b=syJsI9QCRHSvzvgyuxNIO9Zem5eoaYJPGHeIgmmUGtDcmY3SM8UigDDHEWgx23dzm3
         Ub2jO5MwZLpbfpblaQGFtz4JvYykuuXE31iIrocIgvFIcfy/O41HRLdZp15K2zZqsltB
         37AHF4NkLvxcRUK/WwK3vK1jrpItqZOz+An9cqRGUR/gxDgOejCrd65+bIAgHaf2VjG1
         p96nvmbXulrz7xoQDvPbLY60losE/nwYwZVHp3pEElz6zrArekWO7+xTRflg+Oq92Juj
         PtqKb8HSjP8fhRjaJT0G/Tq6tXV+3yslw/NL1NfupVDgBcKR0j8/vKlFi6C1mvvh+JYp
         C5uw==
X-Gm-Message-State: ANhLgQ1daY0L8E3UHzKncSZoyP6CdrY/IPP7OQZr2lxUmwyzJNldGYuO
        fz4cIN3UhB07ki1w0IECmmZpRBH7h6Nrlw==
X-Google-Smtp-Source: ADFU+vv+t1y1eZtIdN4AS3n0B0YgIv/VoMQqKWwNCo04haNIMmZpjP+ejWolBdMAsm2JjzWUtggzvA==
X-Received: by 2002:a17:902:d203:: with SMTP id t3mr1208056ply.291.1584933918770;
        Sun, 22 Mar 2020 20:25:18 -0700 (PDT)
Received: from u2f459ca2e0dd5b.ant.amazon.com ([54.240.193.1])
        by smtp.gmail.com with ESMTPSA id y142sm12279390pfc.53.2020.03.22.20.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 20:25:17 -0700 (PDT)
Subject: Re: [PATCH] x86/memory: Drop pud_mknotpresent()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     jhubbard@nvidia.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <1584925542-13034-1-git-send-email-anshuman.khandual@arm.com>
From:   Balbir Singh <bsingharora@gmail.com>
X-Pep-Version: 2.0
Message-ID: <26021221-7fde-b90a-e55f-d32288443f4e@gmail.com>
Date:   Mon, 23 Mar 2020 14:25:10 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584925542-13034-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: multipart/mixed;
 boundary="------------A7775597DCC6BCF249AE7A67"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A7775597DCC6BCF249AE7A67
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/3/20 12:05 pm, Anshuman Khandual wrote:
> There is an inconsistency between PMD and PUD based THP page table help=
ers
> like the following, as pud_present() does not test for _PAGE_PSE.
>=20
> pmd_present(pmd_mknotpresent(pmd)) : True
> pud_present(pud_mknotpresent(pud)) : False
>=20
> This drops pud_mknotpresent() as there are no current users. If/when ne=
eded
> back later, pud_present() will also have to fixed to accommodate _PAGE_=
PSE.
>=20
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

Makes sense

Acked-by: Balbir Singh <bsingharora@gmail.com>


--------------A7775597DCC6BCF249AE7A67
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
t8N27HWBKnTTl49X+mpkeUQQK0cbMQZEIqlVuA=3D=3D
=3DDEoJ
-----END PGP PUBLIC KEY BLOCK-----

--------------A7775597DCC6BCF249AE7A67--
