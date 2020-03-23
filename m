Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB0FC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B6620409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="hVvfdRx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgCWHro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:47:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44861 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgCWHro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:47:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id w4so13366417lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tNemhAmkl1sC97ky4z5cEU5jjdlE0uUKewIMEJEyzJ8=;
        b=hVvfdRx0erRcY30bjN+sbyE/bqsSqTNdYvemLMYMWnpKOAQUEor8deRsklqX4tWjc3
         4ys0vcqxsiYXGN2NflgKGB06jaPwHLDyXyp+2hyMcsSc8zySGFguQgQxOSv85FKEneFl
         8oNO4rCLXpX7xvt67eN00p8khz+/CIWt0FTlTbaO9xDfNU4Jf4++YTPdCBe8WgD9Zvll
         8UnnKMfRQ9F9Mh5BoHeRJjZN94+oDaUmVYJJaAqyBDPOXtfk6aivEh1mgf7WX4Yplozb
         Vnvk32/7Ar40rg6mULkdvxIbkyJLIQxAVKDG/sknbPIiBVeva7UXUunQQ9W99ZqCujzx
         2w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tNemhAmkl1sC97ky4z5cEU5jjdlE0uUKewIMEJEyzJ8=;
        b=TSOXewZ1yipH8tw13/IihDVrIEm4IxxjROvBOY+y+Tqdm40aJfHXqENcULw5MDHGtZ
         4aTkH94CQMZROJAb3pmTvpsesYb2kwz2td+1fD/FALBDWbdv5e0ZEVL43VJCCXjOy5HE
         286BJD0q34DkckTCKbQ5G1WHF2/quHoWXdRCxwBfbz+M6FDUTzJDT/UoS7eOqQ1xu9rv
         ZheGVgiUAEonC7Vmp2lh52U6Vt1cMLqZ7UTWoBA1evvGzmkBRgpXVzVkTCVlcUMiok/3
         AsMe5AahLgUQENsOKojbaCbtkBG7LNjXKlbdV0rNNpD2VAox9L1LbY3ibV5ddAuhUrdE
         G3Cw==
X-Gm-Message-State: ANhLgQ0XtCRpA3IUs0OKqzbPd83OF75MlNOiUN1WtgTpwim5sFwFdLk6
        hvohlgIeUQKi+YJRepbvnMl8cw==
X-Google-Smtp-Source: ADFU+vvTzGsmzHUi0GbFlRIRrHVNq0/fulaIiAo4xVsXvbsRD+agAie/6i3zPBHF8Dq4sENHzZEnyQ==
X-Received: by 2002:a2e:b701:: with SMTP id j1mr13060175ljo.6.1584949661247;
        Mon, 23 Mar 2020 00:47:41 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f23sm8018219lja.42.2020.03.23.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 00:47:40 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BA4FF100B9B; Mon, 23 Mar 2020 10:47:40 +0300 (+03)
Date:   Mon, 23 Mar 2020 10:47:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, jhubbard@nvidia.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/memory: Drop pud_mknotpresent()
Message-ID: <20200323074740.s5q3ifxvd6ahln7l@box>
References: <1584925542-13034-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584925542-13034-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 06:35:42AM +0530, Anshuman Khandual wrote:
> There is an inconsistency between PMD and PUD based THP page table helpers
> like the following, as pud_present() does not test for _PAGE_PSE.
> 
> pmd_present(pmd_mknotpresent(pmd)) : True
> pud_present(pud_mknotpresent(pud)) : False
> 
> This drops pud_mknotpresent() as there are no current users. If/when needed
> back later, pud_present() will also have to fixed to accommodate _PAGE_PSE.
> 
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

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
