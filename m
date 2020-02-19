Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AC4C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420AF222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="R3gsMk1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSI1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:27:07 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:48693 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbgBSI1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:27:06 -0500
Received: from [192.168.2.10] ([46.9.235.248])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 4KhBjzI7XP9a94KhEjnO9L; Wed, 19 Feb 2020 09:27:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1582100824; bh=gUSKNFP+9NByi0X7P57DBtPalrLuEFSpoKgSKocBbMw=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=R3gsMk1JOobtInm+cPCURhU3hkBED5jTzeRunL8+qIFhp2pxOgllnOS3NSo0hnnh6
         jCliivF9WBN00Q5zqLQmn3mEje88OKUUInQUEPzy8mphSDqx5Ou9IafkNuxgQiU7z4
         z82KPvapWhqJNf4XS3wGfmAB+brVWYC6OlpurhdDdOSSy4DHTRfJMSC4V78LNXpWTi
         hQeWSx615dyptxEhWfZo8SjV7Y6z1l5vcq7YaCCS7z2L6SXSl4+X3OauyFpbs2YLP9
         PJN5zJEMiMKa/zar8xZZXh2QDsu8ac6b9EL7EP9qWfKt7RhSXvEqTUMG/1d6cjto4I
         gA4zljGa80/GQ==
Subject: Re: [RFC][PATCHv2 01/12] videobuf2: add cache management members
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200204025641.218376-1-senozhatsky@chromium.org>
 <20200204025641.218376-2-senozhatsky@chromium.org>
 <964aeb73-1474-032f-b2a6-b317cc15f7cb@xs4all.nl>
 <20200219081638.GB122464@google.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <fc14e35d-5538-abaa-045b-572b3e22f47c@xs4all.nl>
Date:   Wed, 19 Feb 2020 09:27:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219081638.GB122464@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMAGyF3OPLezHQzsDev5SzfS/CwJG5KHnj3Zt9nLCq+8lXFGPaxVu3L19kbfcyXXdodecYZk8Mbdp5ycs7lnEaQF+6I/fZnsDfpzhF5g3HL81/y1DALT
 F2UY3vsXgx84Tbaw6q8+2wGmH/fIlgkebOh7Sm6NWsnKLMG8vkTJriG5gD/dVv6Q40cRc0D/no1aujWC9x0Fv5GylrOhN+cH5c/Nz7B11tPKcUnV3fhDK+eC
 9Ba1qdWCku8Sg2/UYICHlLM+0zXubYy9JC5MxuNIDOzDl0x2iSPiN7QxeSzpkCcM9szUAnyBlxpPDtecwICIr0n/nzP6/3MBNjtyHyQu+nWoUt73nLK2Qn+O
 X+s1kfsdU5pdQr+Tyf0eCou4oeYUJG4hbvTTxjcgZT6yMUzI6c2V0VUDQiTOy8P2OlvBKXaNgOlVY5UQ4lua7ydaGsnrXgywBnjyQ4ffktNGGPUrVSybC60W
 x0fCR8rBnNncpTIBZhOWTRAVHYUariiF4I+7YZL/OQrxONbGEcSI3BqUOdgegMw4a89xDvi64EvGLN7n
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/20 9:16 AM, Sergey Senozhatsky wrote:
> On (20/02/19 09:05), Hans Verkuil wrote:
>> On 2/4/20 3:56 AM, Sergey Senozhatsky wrote:
> 
> [..]
> 
>>> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
>>> index a2b2208b02da..026004180440 100644
>>> --- a/include/media/videobuf2-core.h
>>> +++ b/include/media/videobuf2-core.h
>>> @@ -263,6 +263,10 @@ struct vb2_buffer {
>>>  	 *			after the 'buf_finish' op is called.
>>>  	 * copied_timestamp:	the timestamp of this capture buffer was copied
>>>  	 *			from an output buffer.
>>> +	 * need_cache_sync_on_prepare: do not sync/invalidate cache from
>>> +	 * 			buffer's ->prepare() callback.
>>> +	 * need_cache_sync_on_finish: do not sync/invalidate cache from buffer's
>>> +	 * 			->finish() callback.
>>
>> Shouldn't 'do not' be deleted from the flag descriptions? If the flag is set,
>> then you need to sync/validate, right?
> 
> Hmm, kind of work both ways. Maybe the wording can be more specific,
> e.g. "Do/skip cache sync/invalidation" even more detailed "When set
> perform cache sync/invalidation from ..."

"When set..." works well. It's explicit.

Regards,

	Hans

> 
> 	-ss
> 

