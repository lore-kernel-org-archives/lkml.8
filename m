Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483CCC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE492070A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tk3TsQAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgBKFpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 00:45:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37219 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBKFpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 00:45:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so1920417wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 21:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=upn35/PykylPih5SjrtOcB3Wr/JxTfrTVqi5d6qAqps=;
        b=Tk3TsQAXs5yISP8d1J9lPWqi4Uz6aTXDUUdiQlv8la5sRB98/hhTMi4Hs8zroBdkbF
         UZBt71jujvN26K8k7KrsHdS9vDcGzl0KUaSWuokClPlmyE5iy50sL1AbnF5zgprc9EaM
         N6VmY+QXXmTF/B6Oat7wAM+Uj+w74ca5PoNRcAjagKN6nkgLbRUQdVZPQ4jXgF7eIxFe
         WSIRNXBufv+gpr/g0f6ICQG+jGa7b4fOMZ9bRHJPfJIRKaJ4Y/BTjNIPZg7pWLuEFZ2P
         AZnPdoLNIGmB63JJ015liUwnpuqmFWEBUQFoAVMPLGJdKM57BSYiziKbu0UiHEqqiLAZ
         81LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=upn35/PykylPih5SjrtOcB3Wr/JxTfrTVqi5d6qAqps=;
        b=XeyPp71SCAaXmpGEVoUIlUwgHlI/7Yh5d4MhppoJdb02D3o+Yr6m7BdQDkoiM5fIHo
         hrDCQ7KoPymQOz5xioT6FKS8XBI0cMgj1V0dVeN7UjdXpug7vUblcUlovx1dP9EBzx5Z
         kRIaQ2ILm0rtQJUq1Hncw0Fi9DIBXeyKLd1qIKjZwTmWdmu/SSgQ2gwO4eSMDXA6FqvL
         G8ZAts2Aj2O+1uXQp7AMTKRZKbd6P9/4GlrCkUPVuLSJ7iJJjC8O2C8FKhqVbL5cD7Oe
         nsvteb/h9b2hSlUoDHGn3DN0o695iG/lW9bMhvSz6DCtDtjtuRjtUHzX6OPH4VBLfBFn
         M8dw==
X-Gm-Message-State: APjAAAUXoNAvewi31r2/f1qtlAavlVQFq1x5mWGiSjyKBhkOwFDuY+2+
        pzW1LFXFSz6BcqpsUrmpuavNkw==
X-Google-Smtp-Source: APXvYqygAsO9qHbIGqg709UCKpNlewSUxNe6Dh8uN4RHoJZtaCXckWw550lDGZKaui1PccMPjm3J3Q==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr3643374wmg.16.1581399938921;
        Mon, 10 Feb 2020 21:45:38 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id f62sm2233864wmf.36.2020.02.10.21.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 21:45:38 -0800 (PST)
Date:   Tue, 11 Feb 2020 05:45:34 +0000
From:   Quentin Perret <qperret@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jessica Yu <jeyu@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 2/3] kbuild: split adjust_autoksyms.sh in two parts
Message-ID: <20200211054534.GC72419@google.com>
References: <20200207180755.100561-1-qperret@google.com>
 <20200207180755.100561-3-qperret@google.com>
 <CAK7LNARaEjo7g4=3o-F29Extru8+mYCDqY1i_Gzvra=JB-eZhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARaEjo7g4=3o-F29Extru8+mYCDqY1i_Gzvra=JB-eZhw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 Feb 2020 at 06:08:08 (+0100), Masahiro Yamada wrote:
> In 3/3, you will call this script with $(CONFIG_SHELL) from Makefile.
> 
> For consistency,
> 
> $CONFIG_SHELL $srctree/scripts/gen_autoksyms.sh "$new_ksyms_file"
> 
> is better.

Agreed, I'll fix this in v4.

Thanks,
Quentin
