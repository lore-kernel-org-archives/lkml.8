Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E722C3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6575C20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="O7NYbtAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgBMOUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:20:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42715 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgBMOUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:20:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so4380501lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 06:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mBiaO6Z8OBmXQcABzLnfKyWv3cIy5alz8cnxEzNjtnk=;
        b=O7NYbtAtK8LzZTWMHKsDcBd21xqNpTctsP6CRV1DcAzf5bC+dXiydmb5KkVi3OE4RR
         WqP8NJ6260X7tiFImoZiyeAqz9qcs0hOahNt5wxNKVcrIu6XOj/f8brn3JJk2MH9AB11
         ki+hOnpu0OGAyrmu7KD6ZeI8bfGrdQCn5WLddFZHydDfX1jAFHzNbvjGWo6RYkcywHs6
         C8cvuBnWk9NEbGgHXwl3L8qnQZKIE3PpuHMhkKxittZ/d4eseD0Avbz+pb1SXbtmJIUL
         uDeEuje9rCOamWfbcnIWcxXVHwUFjqqlvr7zB5m6DYSbTwxoRH24qgku86HWLHZrZ68n
         Pb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mBiaO6Z8OBmXQcABzLnfKyWv3cIy5alz8cnxEzNjtnk=;
        b=T662wu+szT5vrnACZw7Eogtq4TFA9BQ1DbQzDCfw7PFnNnshpOcerhXO9GVEiAb6gO
         EBmBmzeNkiA0BP2tMl7t1deEznXdAh8KQa9bg43fTA18IFXhvF2jQjLwsh3SD/zyNRKm
         RDt7KC7Df/xhieO2PiMYTpUywn+DESy8ufB+ZKAHuleaNrQ+VbC9fsRT3QeJEDeX5tbR
         3icTp66ucY34xWDWPZs3PiySSaydpNom5HbXVedhguf2P467mirCP86fuLvMMhZa1eeR
         XNcIP3jupDzpsK0gTMH/xbRw/t2wUoYp2BnU66t2lyhsDn7Dr17x0JaZlm+zDQQTAS9P
         +2HQ==
X-Gm-Message-State: APjAAAWnXdDM8JdopY+wGBQ2SNqGrrGadhp6he9Qxh65QeaqLDr7pz5x
        EFfmgzxmAQG1/oxzToLbcbgSKw==
X-Google-Smtp-Source: APXvYqxdpoct14tGY982jvV4dtpFV6Kly3+FzM3JW5XMXYar2aNa2FtjEVnYdZDlvQBiykpOS2jHVQ==
X-Received: by 2002:a19:8b89:: with SMTP id n131mr9639128lfd.14.1581603616192;
        Thu, 13 Feb 2020 06:20:16 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l3sm1552335lja.78.2020.02.13.06.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 06:20:15 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 79429100F25; Thu, 13 Feb 2020 17:20:37 +0300 (+03)
Date:   Thu, 13 Feb 2020 17:20:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/25] mm: Introduce thp_order
Message-ID: <20200213142037.e2yi3gdn4url7zlj@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-9-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:28PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Like compound_order() except 0 when THP is disabled.

Again, functions are preferred if an option.

-- 
 Kirill A. Shutemov
