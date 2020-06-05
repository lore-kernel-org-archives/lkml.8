Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4997FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15AB12074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gRDL6HY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgFEQUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:20:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49276 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFEQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:20:15 -0400
Received: from [192.168.1.14] (unknown [76.104.235.235])
        by linux.microsoft.com (Postfix) with ESMTPSA id 25ED220B7185;
        Fri,  5 Jun 2020 09:20:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25ED220B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591374015;
        bh=oWQZJZplEJZBqXpZYEbF9oPcUbFjFfMJkc7TjwSg4XE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gRDL6HY3EUJxZLKIcBN0Mxyl58qHMz5tXHSb7XJcVwXco2sX3FtiyUVi8SGtCCeYw
         FPLnx+VzxBGPp6mNMP8lPQWXKUYC4NQjMhaiTtoMRGO1fLcIV7Dmm54YoHsVZsFHJM
         uRFLT+g5ILUaQWtVK+QnKRT5zKrmXX7NgLcADZhw=
Subject: Re: [PATCH] software node: recursively unregister child swnodes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
References: <20200604193623.16946-1-jorhand@linux.microsoft.com>
 <20200604201523.GA1308830@kroah.com>
 <c6150824-60d3-11ad-ba1a-e75d6a7a916e@linux.microsoft.com>
 <20200605075459.GB2209311@kroah.com>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <d8552b13-dbbb-7e4b-9e56-3264435d9225@linux.microsoft.com>
Date:   Fri, 5 Jun 2020 09:20:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605075459.GB2209311@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/20 12:54 AM, Greg Kroah-Hartman wrote:
> Right now, the way the driver model and sysfs/kobjects work is that all
> objects must be removed in child-first order.  The problem of your
> change where you want to try to remove the devices in parent-first order
> is that you do not really know if you still have a reference to a child
> device somewhere else, which would prevent this all from happening
> correctly, right?
> 
> So if you "know" it is safe to drop a child, that's great, and expected.
> Don't work to make  this one tiny user of the kobjects (which I'm still
> not quite sure why they are kobjects and not devices), do things in a
> different way from the rest of the kernel without a strong reason to do
> so.
> 
> thanks,
> 
> greg k-h
> 

I see, thanks for taking the time to explain, the reason for the 
existing behavior is more clear to me now. I agree it is better to have 
the caller remove the nodes in the correct order rather than having the 
swnode infrastructure try to have some special behavior.

Thanks,
Jordan
