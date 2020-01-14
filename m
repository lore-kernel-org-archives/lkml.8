Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0CFC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD69207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TL688tU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgANJaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:30:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51585 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725842AbgANJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578994238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dyYkc635y3Mg5t3JufpcgcFgpvBk0l6C1aELJD+IZMY=;
        b=TL688tU/RHU4+pjDhYwlU6s9D/3WQoBsUOq36QEine0gXfuN50JBs20VWvAUigrYcD1KIn
        +HG74DWJoi/EMvD9YZAxqiSJkwO0hrS1EjSMlKdqcOU4YwBKxfvD8t9qMqx4DPjl0ZzUWq
        Q1D9NnkT+Z4i7eMIPzaGqAD6ZD1waRI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-uHbzjDXbOPu5hzhTLRgufQ-1; Tue, 14 Jan 2020 04:30:36 -0500
X-MC-Unique: uHbzjDXbOPu5hzhTLRgufQ-1
Received: by mail-wm1-f72.google.com with SMTP id p2so3322877wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 01:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dyYkc635y3Mg5t3JufpcgcFgpvBk0l6C1aELJD+IZMY=;
        b=Uo1mbE9Csvw1oeYLtENW0k6fl2ar6y88C05VwW6u6nyRYC0BJxpGqq056GZMNno+8A
         M/c3bKAe7ayZy+/HSZELwOll/FTrPr4We8zoHMpm9zFE88HmvzhKb7/J3eksd0rT8FHz
         x0vLKIyDTxb78qaYcVLQjjmTw3cHfpJ4cCPS/EREHMk+8WBINz7bsweyTNwV3Hwq6YjC
         sTRosbdBqNYJfpC3/NFoOAP+TQTwnVvYZzG6JX63+J5rei6npAJ7ZZ8pbzyEiOay/hop
         L+08Ldb975KWwx9K/iJbYZFvefHkzc/tkk7vgFdm9bMYXjXboE73bVAgbVPLdhsJEnZs
         Fxyg==
X-Gm-Message-State: APjAAAXh0p7e0YYNuY5D6khJOSAcGSC6SsQIQ/Mm89OLlk4pzvGLPaZK
        pUPWGHH4nFcJb2puBuLgH1C9Q6yZbhQEEAuNB1bRtg4CSzQd2o/olB/TYpqT6xrWGg2A4eL2QyC
        Gp87PiRDbH1NmeAHAQq2qO26n
X-Received: by 2002:a5d:528e:: with SMTP id c14mr24834951wrv.308.1578994234052;
        Tue, 14 Jan 2020 01:30:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXeNav3h0jnfLrMNE1EGG4ZAk69SUcIbBWsZFpH1FAmt3/buT/FqY5AJA8v3Z60j/pDg7DlQ==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr24834881wrv.308.1578994233668;
        Tue, 14 Jan 2020 01:30:33 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p17sm17848989wmk.30.2020.01.14.01.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 01:30:32 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lantianyu1986@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, akpm@linux-foundation.org,
        michael.h.kelley@microsoft.com, decui@microsoft.com
Subject: Re: [PATCH] x86/Hyper-V: Balloon up according to request page number
In-Reply-To: <20200114074435.12732-1-Tianyu.Lan@microsoft.com>
References: <20200114074435.12732-1-Tianyu.Lan@microsoft.com>
Date:   Tue, 14 Jan 2020 10:30:32 +0100
Message-ID: <87blr6pepz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Current code has assumption that balloon request memory size aligns
> with 2MB. But actually Hyper-V doesn't guarantee such alignment. When
> balloon driver receives non-aligned balloon request, it produces warning
> and balloon up more memory than requested in order to keep 2MB alignment.
> Remove the warning and balloon up memory according to actual requested
> memory size.
>
> Fixes: f6712238471a ("hv: hv_balloon: avoid memory leak on alloc_error of 2MB memory block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/hv_balloon.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 7f3e7ab22d5d..38ad0e44e927 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1684,7 +1684,7 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
>  	if (num_pages < alloc_unit)
>  		return 0;
>  
> -	for (i = 0; (i * alloc_unit) < num_pages; i++) {
> +	for (i = 0; i < num_pages / alloc_unit; i++) {
>  		if (bl_resp->hdr.size + sizeof(union dm_mem_page_range) >
>  			HV_HYP_PAGE_SIZE)
>  			return i * alloc_unit;
> @@ -1722,7 +1722,7 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
>  
>  	}
>  
> -	return num_pages;
> +	return i * alloc_unit;
>  }
>  
>  static void balloon_up(union dm_msg_info *msg_info)
> @@ -1737,9 +1737,6 @@ static void balloon_up(union dm_msg_info *msg_info)
>  	long avail_pages;
>  	unsigned long floor;
>  
> -	/* The host balloons pages in 2M granularity. */
> -	WARN_ON_ONCE(num_pages % PAGES_IN_2M != 0);
> -
>  	/*
>  	 * We will attempt 2M allocations. However, if we fail to
>  	 * allocate 2M chunks, we will go back to PAGE_SIZE allocations.

This looks correct but I've noticed we also have 

	/* Refuse to balloon below the floor, keep the 2M granularity. */
	if (avail_pages < num_pages || avail_pages - num_pages < floor) {
		pr_warn("Balloon request will be partially fulfilled. %s\n",
			avail_pages < num_pages ? "Not enough memory." :
			"Balloon floor reached.");

		num_pages = avail_pages > floor ? (avail_pages - floor) : 0;
		num_pages -= num_pages % PAGES_IN_2M;
	}

in balloon_up(). If 2M granularity is not guaranteed in the first place
we can't keep it.

Also, when alloc_balloon_pages() is called with 2M alloc_unit and the
region is not 2M aligned, it will return someething < num_pages, the
next condition, however, only checks for 0:

                if (alloc_unit != 1 && num_ballooned == 0) {
                        alloc_unit = 1;
                        continue;
                }

we will proceed to sending a response to server and try doing next
iteration by calling alloc_balloon_pages() with 2M alloc_unit again,
this will finally return 0 and we will switch to 4k. I think we can
optimize this to:

                if (alloc_unit != 1 && num_ballooned != num_pages) {
			alloc_unit = 1;
		        continue;
		}

-- 
Vitaly

