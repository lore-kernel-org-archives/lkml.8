Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5457AC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 348CB208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ia/EBnk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgD2Qgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:36:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20737 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726423AbgD2Qgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588178202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLCOuqa7ZtYZ+MUxTqaejPdid6hmi2iHBAVG7Nm83JQ=;
        b=ia/EBnk/bFqaLEwYppTEPszpdCdYrVqYdhmBiL7VjXYmIhslhfroN8db2QaZf50PCetJgb
        W6hwfffHuERcB/P/3YqeoBIyBIdrK4vlJwzqeS/boldS2Y34ipJ+Y+MbpqiSg3qUbX5wC8
        zaoWHlOP6VzCRirYvinUm1EvCD1w/Kc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-Xgl-Ofg7N2uySCyYX1Hstw-1; Wed, 29 Apr 2020 12:36:35 -0400
X-MC-Unique: Xgl-Ofg7N2uySCyYX1Hstw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B313EC1BC;
        Wed, 29 Apr 2020 16:36:33 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-218.rdu2.redhat.com [10.10.115.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64B205D9C9;
        Wed, 29 Apr 2020 16:36:31 +0000 (UTC)
Subject: Re: mm/slub: do not place freelist pointer to middle of object if
 redzone is on
To:     Markus Elfring <Markus.Elfring@web.de>,
        Changbin Du <changbin.du@gmail.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>
References: <ca36745b-1939-2640-aeed-390c8c39114e@web.de>
 <20200425235105.sye7fsbndbv24b46@mail.google.com>
 <dc9bcaad-ee13-5359-5d99-7ecb8cb1d46b@web.de>
 <20200428231855.5czf4penpbowliz6@mail.google.com>
 <b1b93915-696b-c6e2-d122-f01121188bdc@web.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9c4c71cf-a5e0-5594-676c-80ca65d5d214@redhat.com>
Date:   Wed, 29 Apr 2020 12:36:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b1b93915-696b-c6e2-d122-f01121188bdc@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/20 4:00 AM, Markus Elfring wrote:
>> Waiman just posted another fix for this issue. Let's use that patch instead.
> With which patches should the situation be finally improved
> also for this software component?
> https://lore.kernel.org/patchwork/project/lkml/list/?submitter=21412
>
> Regards,
> Markus
>
The "mm/slub: Fix incorrect interpretation of s->offset" v3 patch that I 
sent out this morning should fix the problem.

Cheers,
Longman

