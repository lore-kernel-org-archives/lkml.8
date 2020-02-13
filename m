Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBDAC3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BC92168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="VVu0rajx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgBMN6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:58:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35134 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbgBMN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:58:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id q8so6717395ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MXKPRgQyjfEBEssBb4S8+9+QLdHW4asZtIOfI7X/G9o=;
        b=VVu0rajxgf9FqovZRSAKOCd2ZcTalbIBV+HO8Py2CjfXwk8MWsbIbghaQuasvcF/+U
         H/quroMyQicpHYeLnx1g5na9K3FojygRUMbyNHGQcIYgc8dUiecYmSe7AyYRZ2MvaYpk
         fgopSMEUF4Me49fLQoyNVl1ps4Ql0JwNEIO3OFInKW+y4S/XqOxvgef7jv2j4Ome5/yF
         ZSxDlgryZ/1J4CRia648T1vvgzRLl9AhZMg1NzvtFP7Ca5m3fGneuoht2xaKP4r4HYKZ
         XSBrqRv8a92f5ie59ZGd8obKZvKzR8vCkcm9sHzB9G7oj4b4bveBhCbnuQADDkUp+AmX
         ZQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXKPRgQyjfEBEssBb4S8+9+QLdHW4asZtIOfI7X/G9o=;
        b=UP3xgozEl/Ul1Lz+JLqqhkaGmkhmlKtATmvQ0A5sqcMyrQ4xnp2mINEynIZJazAjue
         nYMukrqftrcd8suqIl1TtFKf+DIHXORamwp9XZtId5uVMKFHeV0RmFQY+JdMslhR39tz
         MVBecyvQprAzuJsTE4nJCquTlfbUJnAuQfzjeFW9smzlhOfjbiyN0bdpXFRHBzhIxvBX
         Pn33SeoxbTpwFR/jJtP5Xx8rQfIJXikrCR7FV+efW5MoCyxFJ9GCrFvt5l+m4LoqyPJf
         mxU44SfevFXY8MHhesRJnk5ByXnRqjrtyTNoLfV9WoHpxrmyRaTSrGaX2jqcpFhQpXP3
         u4pQ==
X-Gm-Message-State: APjAAAXW5iJbQ8Jr207H64EoVnif/EyRCCXWipxXT9MbYrvt+j8y0zC8
        P4DkDwiPffA9yx9XvaKNRdeERA==
X-Google-Smtp-Source: APXvYqxtQ5xhvBNlTf/I5i2m5kmfUVMJeeTpcg3PxBH6F239q4SAWYQkxIWdvMTJ35Rx0Rht6aAqRQ==
X-Received: by 2002:a2e:b8d0:: with SMTP id s16mr10492992ljp.32.1581602323947;
        Thu, 13 Feb 2020 05:58:43 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d20sm1513385ljg.95.2020.02.13.05.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:58:43 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 685D3100F25; Thu, 13 Feb 2020 16:59:05 +0300 (+03)
Date:   Thu, 13 Feb 2020 16:59:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/25] mm: Fix documentation of FGP flags
Message-ID: <20200213135905.wvpeiw7tyma75tsq@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-6-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:25PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We never had PCG flags

We actually had :P But it's totally different story.

See git log for include/linux/page_cgroup.h.

-- 
 Kirill A. Shutemov
