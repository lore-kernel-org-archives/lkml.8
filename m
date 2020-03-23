Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B032C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EF0206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUvXg8Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgCWMfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:35:31 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36303 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgCWMfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:35:30 -0400
Received: by mail-pj1-f65.google.com with SMTP id nu11so6039056pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VzwPSZbs06tTKNRZDvRedEakK8DwlP6wfcMOmcIPDiQ=;
        b=YUvXg8JeKwhErLrKCF1xiN6mn9vENO+w+J9yWrzvE/FIO5ls7p5oPerFSlcD3H9sIq
         OeZO23NJjY60VCwo3rzZoSPD5vd3kltarou47rqy8q5xQqCTAP9qjSFBj7lOaHFxvSfu
         SWz8JCaZ8U+bplzJApgAtEp2CHp8wXVn1/Jw5R9fippvB0z0W7muyKthEPT1KyPx3gWG
         agHVqpB5uF2qG69Q6GfUydSdoKsRMjmtxMMometkHMxsBLyvc0D+BCC47GnzJIXbClNW
         HsuJt1bCdMWbDk+gglWuybD2XbIPLc1irLXl4Xjz0yosrfyTQEuCNH230M0aqu2upHEN
         ptFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VzwPSZbs06tTKNRZDvRedEakK8DwlP6wfcMOmcIPDiQ=;
        b=C0nx4dSux+mHYRczB+RiCfLjYClBWhjTWSaZs4+Q8mGloaQOPlE3ZplBR4ug+eUmCa
         XJbdpDQ9fF4f8oYqwqw0jM5d+oZp9wHxn+M6sS0HDDSCfF76G8azJTygtpR4FtBp/I5C
         bx435VBu3dW5Ys+cIZeR0VkQOCk7jsHa2BcrfsgXO+3HSi8bWk7tmF55cW8kiiGC6cVO
         0SQBUaErFsilxQYl0Enifz85lbIlGRpQObwJSQq13honrgWsUt5JzqMW0P7+PEIucovE
         OrUU0CITo1rK9IpsHqSNAjPYMCCArHKFh9xVd7xWBD0hjfqDu/clm6RzfUFOjSBVuD7q
         aauA==
X-Gm-Message-State: ANhLgQ3nJypTt2vEqoIjq0ooseeemXki015SsRoxCM7Uj4tVqNa2unFv
        yeSxnu0Pjs+eECb0FUD+UNY=
X-Google-Smtp-Source: ADFU+vtarkTB9uyKT4ILRH3RXgRnkAP3/KXJ7VJXqWayfL97rEDtMrQGje9p4tznojK1PkeJy3F5/A==
X-Received: by 2002:a17:90b:908:: with SMTP id bo8mr24900638pjb.74.1584966929847;
        Mon, 23 Mar 2020 05:35:29 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a2sm12229487pjq.20.2020.03.23.05.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 05:35:29 -0700 (PDT)
Date:   Mon, 23 Mar 2020 20:35:26 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     changbin.du@gmail.com, linux-kernel@vger.kernel.org
Subject: Two questions about cache coherency on arm platforms
Message-ID: <20200323123524.w67fici6oxzdo665@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All,
I am not very familiar with ARM processors. I have two questions about
cache coherency. Could anyone help me?

1. How is cache coherency maintenanced on ARMv8 big.LITTLE system?
As far as I know, big cores and little cores are in seperate clusters on
big.LITTLE system. And cache coherence betwwen clusters requires the
memory regions are marked as 'Outer Shareable' and is very expensive.
I have checked the kernel code, and seems it only requires coherence in
'Inner Shareable' domain. So my question is how can linux guarantees
cache coherence in 'CPU migration' or 'Global Task Scheduling' models
wich both clusters are active at the same time? For example, a thread
ran in Cluster A and modified 'Inner Shareable' memory, then it migrates
to Cluster B.

2. ARM64 cache maintenance code sync_icache_aliases() for non-aliasing icache.
In linux kernel on arm64 platform, the flow function sync_icache_aliases()
is used to sync i-cache and d-cache. I understand the aliasing case. but
for non-aliasing case why it just does "dc cvau" (in __flush_icache_range())
whithout really invalidate the icache? Will i-cache refill from L2 cache?

void sync_icache_aliases(void *kaddr, unsigned long len)
{
	unsigned long addr = (unsigned long)kaddr;

	if (icache_is_aliasing()) {
		__clean_dcache_area_pou(kaddr, len);
		__flush_icache_all();
	} else {
		/*
		 * Don't issue kick_all_cpus_sync() after I-cache invalidation
		 * for user mappings.
		 */
		__flush_icache_range(addr, addr + len);
	}
}

-- 
Cheers,
Changbin Du
