Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D657BC3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5742073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DlkEkNZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgBLCHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:07:46 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34713 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgBLCHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:07:46 -0500
Received: by mail-pj1-f65.google.com with SMTP id f2so1339202pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 18:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XfXQzEXK/40yroZE0WNrO0xGbb0dPANvOZRe3DecyDs=;
        b=DlkEkNZ143FuGHyJDBiGhBWZGuw9BmGtJntu88b+qG8Wy/4BGIua6grAgl58/D8q6V
         bg7bGuCteUJx6urWsoOGAVo8c1MrA8b2pG0/fcuQZuo/3JcTIEE73K3fmyLn9yhxKkg6
         42oRI5iUl1mzf+2uM4Z/Kbi3ux+CdnOIq1fdN+fJgmqBIRaqnAxrYUbvA6L/8YYfg+K1
         GZGPxRlOp1AwC5NLUD2OqYoLBZ1lkZRZZ40WllIKQx35iFIQ7gA0r61pUpyy/AFxnlDf
         1SQZsQx08pN3u0xznbDlXl8+RMULAZJIwxsLzICZgrishQjVpLvTVG7QnsfY6ASYMJ52
         lblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XfXQzEXK/40yroZE0WNrO0xGbb0dPANvOZRe3DecyDs=;
        b=HNV+UoD4PO5OhIiF1RIKFs1X/nG9FGFpl76hadiqmP0jhrkHFX25GPcE/QYOsOG1H2
         Fjp+pXLzgsncyRljrVPawYClC9QlXClWSyGBDfriXdm5u2DPw7WKmHzNdqRAxM2VWoZy
         Nc3FljwuTYege6miqae9eJubHzDs8uY0rsaGxdkFFQMzc80MPqfu6VNRB94CLKbgtETz
         G1HW0QKHCkszlcCDqU8S1OAgq+q+E8vJvWURsZ4wiKcaOdDJsWBJN56j5t1no8rI0T3C
         XET3mPe7vQ1egH2stGkcfGw1ZaeERW6+cCRagMRmlgmgcsPLpjT8DHQdVhYrF9UTv1Z3
         NCBw==
X-Gm-Message-State: APjAAAUGQmoWXIgLBuHZRNMknJ7L+5BdHqG9+enHOS9DSUy14vWpcq6N
        4B8MSHcURpfuV1oovLTHoIoKVg==
X-Google-Smtp-Source: APXvYqxPO/2KQ/rnpQeZBhcp/zpptuwRGJx4OSvUosykfQg3ovinE6r2/KQB8g2QRqkEf7qjKqwkTg==
X-Received: by 2002:a17:90a:a416:: with SMTP id y22mr7227341pjp.114.1581473264298;
        Tue, 11 Feb 2020 18:07:44 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q28sm5933860pfl.153.2020.02.11.18.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 18:07:43 -0800 (PST)
Date:   Tue, 11 Feb 2020 18:07:43 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmpressure: don't need call kfree if kstrndup
 fails
In-Reply-To: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.2002111807310.170855@chino.kir.corp.google.com>
References: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020, Yang Shi wrote:

> When kstrndup fails (returns NULL) there is no memory is allocated by
> kmalloc, so no need to call kfree().
> 
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: David Rientjes <rientjes@google.com>
