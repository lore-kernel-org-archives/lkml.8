Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C063AC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 00:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DE0206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 00:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW4Udd85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgD0Acq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 20:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbgD0Acq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 20:32:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA87C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 17:32:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d3so636472pgj.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 17:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+j9x8dUw2KVJxkUyAsf0p1IpWa0VFiRZyuAmruZ92kY=;
        b=PW4Udd8509L2xLh6rmRMXc1t7/a2YEEqQPXyp1aU59BXTk274mmPyDDlvuSHPQ0dZ/
         FTl4K/5qoh7l+QhlUacYhmAV0t9np1ixF2Xs3uPsx2KhMbOLEYf9t3AdE3WhITpS52/p
         w/BK4MtTFc01oaaywpzs6ZRnJOQ8R65J4D8J5RQ6la6HW5BkxHtTruNaKmoqWcgNhu6W
         ybeT91wBTripM+rMzuhPr7TRN7w2ULdtNtsCiil9fEOmhSWK/UtoJmPLNmo/DWSRS1zJ
         +0321XSogXkxfmm+skSLapXtrrJ31OpzuLyw6lrA7d5CRSXYLA/x9LhhFI+eaJyj+cfs
         Y+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+j9x8dUw2KVJxkUyAsf0p1IpWa0VFiRZyuAmruZ92kY=;
        b=k/+sI5im6RPlBKZi/G23DGgEu3DohXH/CE9wIEnvqNfFT89hmNCcHT+5lOh1E5nrUR
         RmmskbahwtXUa3NR9aZ7h6IwujvCJrbbamI9OdTDurlBjJVOi2QS47II8WYsdBkVD0Ww
         T57eHfoEjaqJCAOu+vVLSaAtIcSi4C+qmsh98kK0q6GzpNlGzO5jTvNuu32mE3JJScJH
         1ubZ/7rEXBBWoGD0vp5MgKfTJZ5ws7U/N4mKaY6qmF1N9SiruiY85GjmU8JlO4rnnc9p
         KjxitDyDhMZLMsTpPGGAfBj6kg/RKjpGIki1YLCfR+c1Mt4pRDgC1OcxT9XL75zOiIL8
         FM4A==
X-Gm-Message-State: AGi0PuZtIbo2uGBVfxNF7Lo9tFKMPXBUv46S5CUOJfipOXq2zkimiMsl
        fe3if604RVqWhRc8raT3Q6ftBxAEvI7skw==
X-Google-Smtp-Source: APiQypIhobm196tq9HQTllNIHN6R0ssBPkDWmgNGXZ+sRzqGfTgDsMYk7xVVTkUpPrpdqMja0YZnag==
X-Received: by 2002:a63:d806:: with SMTP id b6mr19902712pgh.72.1587947565538;
        Sun, 26 Apr 2020 17:32:45 -0700 (PDT)
Received: from host ([154.223.71.61])
        by smtp.gmail.com with ESMTPSA id h31sm10068447pjb.33.2020.04.26.17.32.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Apr 2020 17:32:44 -0700 (PDT)
Date:   Mon, 27 Apr 2020 08:32:41 +0800
From:   Bo YU <tsu.yubo@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] include/linux: delete duplicated kernel.h in
 nodemask.h
Message-ID: <20200427003239.kafheof34qn2bg76@host>
References: <20200426154230.xwglw6k5c3kwyco5@debian.debian-2>
 <20200426170942.GB2139089@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200426170942.GB2139089@kroah.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 07:09:42PM +0200, Greg KH wrote:
>On Sun, Apr 26, 2020 at 11:42:35PM +0800, Bo YU wrote:
>> In nodemask.h, it includes bitmap.h which has included kernel.h,
>> so delete kernel.h from nodemask file.
>>
>> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
>> ---
>> BTW, I do not get maintainer of the get_maintainer file, so i do
>> not know who can accept the patch if it is right.
>> ---
>> include/linux/nodemask.h | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
>> index 27e7fa36f707..980b48e05d05 100644
>> --- a/include/linux/nodemask.h
>> +++ b/include/linux/nodemask.h
>> @@ -46,7 +46,7 @@
>>  * int next_node(node, mask)		Next node past 'node', or MAX_NUMNODES
>>  * int next_node_in(node, mask)		Next node past 'node', or wrap to first,
>>  *					or MAX_NUMNODES
>> - * int first_unset_node(mask)		First node not set in mask, or
>> + * int first_unset_node(mask)		First node not set in mask, or
>>  *					MAX_NUMNODES
>>  *
>>  * nodemask_t nodemask_of_node(node)	Return nodemask with bit 'node' set
>
>That change is not described above :(
I promise i just delete kernel.h in the nodemask file. I am wonder why
change the comment also :)
>
