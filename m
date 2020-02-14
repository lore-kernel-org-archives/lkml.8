Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4A1C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0B1206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="2TKMT+CY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgBNNw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:52:29 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42072 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgBNNw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:52:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so6789809lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 05:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tdtqJsclM4uhuI49pOeI8DovFeuAeipuZdS8MF+ZWv4=;
        b=2TKMT+CYVGT6tGMCX3C6ArI+zF6FCg+KFoCVV+Dp1uBA+j0Bypp6RS3QcMMgk9JKK2
         +5FkZGsWlh+c73qUM1dgCbXrCaIDpNSxv5yZ4QZGVultrVfS0230WquGpTX7bWMQZwRL
         Itk86oLVC12ZSIKyd+5Sx5M0SqXlOC3Y1FMECprDAznUARuH7ImGLSbmH4a9xgwU8KDC
         H7AaI8p81Izim+CXybf3/U1g3yEyxDRIfmr7NBAeUS+PpoX/CPSvou/vpz3us8w80e0/
         CgqPwGd05MoNEx6XvJl4K5/6Pn2O/mUOFIQN+NUEkqVeV/p3NW0POTievY/0WitDLk0/
         XyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tdtqJsclM4uhuI49pOeI8DovFeuAeipuZdS8MF+ZWv4=;
        b=I/ZY2cw+AQS0N0I9NIDXwRgpbd0ITpX6cSVI3Y10GZF3xgZvuABRQ71kl7L3U4CvwC
         9rwEdsxi5t1Xyj+vMzBOYS33kYvDbPiapmQcsbW01WSY7yOocDHDOgKyrTV8D0nQhYtL
         /oup9NIIlj/dBzGxQgOMTtk/BYSvNVqrBppMxQssNnKN8qeyEVcbm8QBEAgk0VK/zD4f
         uC/y2gKsL+WU+vbabGzM39TyfmXiwJ3ADXVSP9xZa3IKoWrX2qllrJNEac1VjDSEISPW
         EG0mgHE6BopYP2ZTP9VfroaWXH0mIzwF3wmGjL5A4gEGasy4iJpzgaZBDJw66/A/NWpB
         3vNQ==
X-Gm-Message-State: APjAAAVgu2b+F0LNMAeCp6YlfZz99G3FV+j95V3ZF4GJMXfnh09PtIsl
        G1k3vykh0dKnWzps2KK256prHgqhAhk=
X-Google-Smtp-Source: APXvYqxKZSFPG4dqXvYMd4rmSifXuXeg3DODSZO8QZQljvwGRQPXEzK9MqFBoZOwwF5DbIqRkuXUEQ==
X-Received: by 2002:a05:6512:4c6:: with SMTP id w6mr1721466lfq.157.1581688346526;
        Fri, 14 Feb 2020 05:52:26 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 23sm3661546ljw.31.2020.02.14.05.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:52:25 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3DAEF100F7E; Fri, 14 Feb 2020 16:52:48 +0300 (+03)
Date:   Fri, 14 Feb 2020 16:52:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/25] fs: Add zero_user_large
Message-ID: <20200214135248.zqcqx3erb4pnlvmu@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-14-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:33PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We can't kmap() a THP, so add a wrapper around zero_user() for large
> pages.

I would rather address it closer to the root: make zero_user_segments()
handle compound pages.

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/highmem.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index ea5cdbd8c2c3..4465b8784353 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -245,6 +245,28 @@ static inline void zero_user(struct page *page,
>  	zero_user_segments(page, start, start + size, 0, 0);
>  }
>  
> +static inline void zero_user_large(struct page *page,
> +		unsigned start, unsigned size)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < thp_order(page); i++) {
> +		if (start > PAGE_SIZE) {

Off-by-one? >= ?

> +			start -= PAGE_SIZE;
> +		} else {
> +			unsigned this_size = size;
> +
> +			if (size > (PAGE_SIZE - start))
> +				this_size = PAGE_SIZE - start;
> +			zero_user(page + i, start, this_size);
> +			start = 0;
> +			size -= this_size;
> +			if (!size)
> +				break;
> +		}
> +	}
> +}
> +
>  #ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE
>  
>  static inline void copy_user_highpage(struct page *to, struct page *from,
> -- 
> 2.25.0
> 
> 

-- 
 Kirill A. Shutemov
