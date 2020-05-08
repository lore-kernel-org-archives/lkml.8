Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA6DC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1CB021841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQKrs7oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgEHOts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:49:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58434 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726913AbgEHOtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588949387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fb8b/E+I8GNinMLAG3XjpAJ4w3ipQUW2Yz7X64JjL5Y=;
        b=iQKrs7oy1FX/06rlRZj9cWBz2+BlGQPq4IO8zq4M170o6kl2Z5z5hBtiXrXTZdEN1iBya5
        K/Ugz6VtlRVj8fYrQcGTgUmjkWc5t53dkBPDjBpzJMC+egjLPGueVOvm46oWM1C08gn9Vj
        NgIGwcd6PHiVsBhjG04Xj0NHjZSguiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-lVRf-TgwMbGXGeIqmN_y0Q-1; Fri, 08 May 2020 10:49:45 -0400
X-MC-Unique: lVRf-TgwMbGXGeIqmN_y0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFFB41895A28;
        Fri,  8 May 2020 14:49:43 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-83.rdu2.redhat.com [10.10.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2831019C4F;
        Fri,  8 May 2020 14:49:43 +0000 (UTC)
Subject: Re: [PATCH RFC 1/8] dcache: show count of hash buckets in sysctl
 fs.dentry-state
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
 <158894059427.200862.341530589978120554.stgit@buzz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7c1cef87-2940-eb17-51d4-cbc40218b770@redhat.com>
Date:   Fri, 8 May 2020 10:49:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158894059427.200862.341530589978120554.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 8:23 AM, Konstantin Khlebnikov wrote:
> Count of buckets is required for estimating average length of hash chains.
> Size of hash table depends on memory size and printed once at boot.
>
> Let's expose nr_buckets as sixth number in sysctl fs.dentry-state

The hash bucket count is a constant determined at boot time. Is there a 
need to use up one dentry_stat entry for that? Besides one can get it by 
looking up the kernel dmesg log like:

[    0.055212] Dentry cache hash table entries: 8388608 (order: 14, 
67108864 bytes)

Cheers,
Longman

