Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC01EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B850C208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590664279;
	bh=ki29YA5N+T9mFWtkVk4TJL3cfcAoBnTCNqbg8DxOHCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kfI7F491LAJAiGexZ8kr+5IMNk65O2G9V9s4VXH0Zxr6D/cEO2Op8z+7UnQk24maw
	 pJlF/rIunx3DiBT+F1CwaFbjjlGigSNe/kV8NSwwA/u6cw6ktAsTEGtz17OVVgmdie
	 /EnD/v8PKsnGd0dswglWjTpUDwRKAOxvmonNxa2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbgE1LLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388078AbgE1LLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:11:18 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C962088E;
        Thu, 28 May 2020 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590664278;
        bh=ki29YA5N+T9mFWtkVk4TJL3cfcAoBnTCNqbg8DxOHCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=anzf/W4Kc1OljXga9k7iPjG3CMvMKjyHwJwTtUCqNbA9kIEHZtpEjobFGkouGqC1P
         Hyy1d+WUH9PV8tLo/jvl59GJ8RAQbRd3+6hfeCp1vU7oQFB0WVLYnc+xAeOhXt/PC6
         nv2Pg541XeitM8JCFKkqKxohETCrfQ9XjTX93Jlc=
Date:   Thu, 28 May 2020 07:11:17 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 5.6 086/126] virtio-balloon: Revert "virtio-balloon:
 Switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM"
Message-ID: <20200528111117.GK33628@sasha-vm>
References: <20200526183937.471379031@linuxfoundation.org>
 <20200526183945.237904570@linuxfoundation.org>
 <8f649042-bc3a-2809-0332-44a5d3202807@suse.cz>
 <c8253932-5e6b-51e1-fe0c-19514779c9be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c8253932-5e6b-51e1-fe0c-19514779c9be@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:21:41AM +0200, David Hildenbrand wrote:
>On 28.05.20 07:51, Jiri Slaby wrote:
>> On 26. 05. 20, 20:53, Greg Kroah-Hartman wrote:
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>
>>> [ Upstream commit 835a6a649d0dd1b1f46759eb60fff2f63ed253a7 ]
>>>
>>> This reverts commit 5a6b4cc5b7a1892a8d7f63d6cbac6e0ae2a9d031.
>>>
>>> It has been queued properly in the akpm tree, this version is just
>>> creating conflicts.
>>
>> Should this be applied to stable trees at all?
>>
>> To me, it occurs to be a revert to avoid conflicts, not to fix something?
>
>Agreed.

Right, I'll drop it - thank you.

-- 
Thanks,
Sasha
