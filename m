Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4231CC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DF321741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/K5j4bR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBFEeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 23:34:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43326 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgBFEeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 23:34:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id z9so5443653wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 20:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n249e5HNQz63XwR/f8zPGsdJTlfZY+kApZiMCpDM55E=;
        b=S/K5j4bRHrzkwiQ32hJBQvgOAscTM0cSw3DgQMEk6KSJQW7YU7aWyxXb+NmYXXucKB
         ZGSt1hOP5TNy2XH/vb+2KdOykuM8o/p9YAudV/kW3OmiAz0x7jV3g3k1QP3WuNUrRHth
         Kt7sDhtQ4cm6bnJICqsYpb3VkaIhRR1ymPcZWVjDMvRwQTF65sgG365abV6W82+m6JAl
         S1Tne6P0a6kfBSVwJH5XFJsY5aNCNtNfHZZUmgZcGTTWKBNOhgxGkR1awLmQt1w/oI5h
         fN+3uvwonuofoxNd9F+sq+DXtaQvzcJzZOy4Do7uwidSo2UanTIVq9OWa/nmV5/RqF+g
         KGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=n249e5HNQz63XwR/f8zPGsdJTlfZY+kApZiMCpDM55E=;
        b=stkrKkNNkG0lXypEtWOsrFtmRLm77rIpBkU/FBeVZHDqLgCmL5QKpoakvQ7VAb3HeX
         wp3w7WkKpheKwMcPGsiu+RFX+sWS9/xZA/ALmXg8XIZdf4YXXgTIu4ntYz5X3AaJdSLK
         TiMOJCKYifIUg4zE6mz2BV510TwKbK/lnZpZL0CF4ads0/SstPmV7TG34sQv4V/2BDYl
         tAPiWizQtpC3Wt0UI7mjOS6T5LZ4vnDoX8m4EcBXt6bh+RMgq7kGmBuXsM+UImloP5+v
         J7aNarkV1tiOGt+B+hJ5nemXAAxQN7Kl3iNM54/OlMEy5q3n/T5s+p7Au/PezC+qugSh
         09lg==
X-Gm-Message-State: APjAAAW8HQax2aYiFRaIjTCXt/2N4mpUyjdi5KDue/LspWXuWKIB1MHN
        oREEm1k4ic1bNAH+fs/eMau0+YtE
X-Google-Smtp-Source: APXvYqwEzGAGucgEhWWZLDukrhQ6bAbhVdMGdJNzMuJq4Gu7wCrO0IjqhuKaoFVnPRHgAz/cZb2AiQ==
X-Received: by 2002:adf:fa43:: with SMTP id y3mr1277904wrr.65.1580963642605;
        Wed, 05 Feb 2020 20:34:02 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d23sm2656987wra.30.2020.02.05.20.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 20:34:02 -0800 (PST)
Date:   Thu, 6 Feb 2020 04:34:01 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: Easier calculation to get pages to
 next section boundary
Message-ID: <20200206043401.22i2cucwqctsrtps@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200205135251.37488-1-david@redhat.com>
 <20200205231945.GB28446@richard>
 <20200205235007.GA28870@richard>
 <20200206001317.GH8965@MiWiFi-R3L-srv>
 <20200206003736.GI8965@MiWiFi-R3L-srv>
 <20200206022644.6u7pxf7by2w5trmi@master>
 <20200206024816.GK8965@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206024816.GK8965@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 10:48:16AM +0800, Baoquan He wrote:
>On 02/06/20 at 02:26am, Wei Yang wrote:
>> On Thu, Feb 06, 2020 at 08:37:36AM +0800, Baoquan He wrote:
>> >On 02/06/20 at 08:13am, Baoquan He wrote:
>> >> On 02/06/20 at 07:50am, Wei Yang wrote:
>> >> > On Thu, Feb 06, 2020 at 07:19:45AM +0800, Wei Yang wrote:
>> >> > >On Wed, Feb 05, 2020 at 02:52:51PM +0100, David Hildenbrand wrote:
>> >> > >>Let's use a calculation that's easier to understand and calculates the
>> >> > >>same result. Reusing existing macros makes this look nicer.
>> >> > >>
>> >> > >>We always want to have the number of pages (> 0) to the next section
>> >> > >>boundary, starting from the current pfn.
>> >> > >>
>> >> > >>Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
>> >> > >>Cc: Andrew Morton <akpm@linux-foundation.org>
>> >> > >>Cc: Michal Hocko <mhocko@kernel.org>
>> >> > >>Cc: Oscar Salvador <osalvador@suse.de>
>> >> > >>Cc: Baoquan He <bhe@redhat.com>
>> >> > >>Cc: Wei Yang <richardw.yang@linux.intel.com>
>> >> > >>Signed-off-by: David Hildenbrand <david@redhat.com>
>> >> > >
>> >> > >Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> > >
>> >> > >BTW, I got one question about hotplug size requirement.
>> >> > >
>> >> > >I thought the hotplug range should be section size aligned, while taking a
>> >> > >look into current code function check_hotplug_memory_range() guard the range.
>> >> 
>> >> A good question. The current code should be block size aligned. I
>> >> remember in some places we assume each block comprise all the sections.
>> >> Can't imagine one or some of them are half section filled.
>> >
>> >I could be wrong, half filled block may not cause problem. 
>> >
>> 
>> David must be angry about our flooding the mail list :-)
>
>Believe he won't, :-) If you like, we can talk off line.
>
>> 
>> Check the code again, there are two memory range check:
>> 
>>   * check_hotplug_memory_range(), block/section aligned
>>   * check_pfn_span(), subsection aligned
>> 
>> The second check, check_pfn_span() in __add_pages(), enable the capability to
>> add a memory range with subsection size.
>> 
>> This means hotplug still keeps section alignment.
>
>memremap_pages() also call add_pages(), it doesn't have the
>check_hotplug_memory_range() invocation. check_pfn_span() is made for
>it specifically.
>

If my understanding is correct, memremap_pages() is used to add some dev
memory to system. This is the use case which Dan want to enable for
sub-section. Since memremap_pages() is not called in mem-hotplug path, this
doesn't affect the hotplug range alignment.

>> 
>> BTW, __add_pages() share the same logic as __remove_pages(). Why not change it
>> too? Do I miss something or I don't have the latest source code?
>
>Good question, and I think it need. Just David is refactoring/cleaning
>up the remove_pages() code path, this is found out by Segher from patch
>reviewing.

Ah, we may need a following cleanup :-)

-- 
Wei Yang
Help you, Help me
