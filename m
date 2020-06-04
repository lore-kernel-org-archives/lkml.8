Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC31CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800DC2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W6PfPVKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgFDU5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:57:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36334 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgFDU5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:57:07 -0400
Received: from [192.168.1.14] (unknown [76.104.235.235])
        by linux.microsoft.com (Postfix) with ESMTPSA id E175120B7185;
        Thu,  4 Jun 2020 13:57:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E175120B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591304227;
        bh=Wgn0x3zC/o4zblELYidkRAENBz/ajl7eE6ze+n4i+58=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W6PfPVKVNfCF7A/5tLhh6/6oaQ5Gkzp+2zaVW0Zd97RGfMwrn17II0v9RsMl/c+jF
         HLz+4P4yZA/R4fsJ9NgT9qcWlkj9hUgVw5YX19L882wIy6Ai7jHfePemA649MXr1OZ
         n6AFDnoCccmf7XL3+Ee26Toxm5c3p5hQJo9ZrYmc=
Subject: Re: [PATCH] software node: recursively unregister child swnodes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
References: <20200604193623.16946-1-jorhand@linux.microsoft.com>
 <20200604201523.GA1308830@kroah.com>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <c6150824-60d3-11ad-ba1a-e75d6a7a916e@linux.microsoft.com>
Date:   Thu, 4 Jun 2020 13:57:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604201523.GA1308830@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/20 1:15 PM, Greg Kroah-Hartman wrote:
> On Thu, Jun 04, 2020 at 12:36:23PM -0700, jorhand@linux.microsoft.com wrote:
>> From: Jordan Hand <jorhand@linux.microsoft.com>
>>
>> If a child swnode is unregistered after it's parent, it can lead to
>> undefined behavior.
> 
> Crashing the system is not really "undefined" :)

Fair point :)

> 
>> When a swnode is unregistered, recursively free it's children to avoid
>> this condition.
> 
> Are you sure?  Why would you be unregistering a child after it's parent?
> Why not just do not do that?
> 

The main motivation for doing this was to support 
`software_node_unregister_nodes` so that the passed list of nodes does 
not need to be ordered in any particular way.

I suppose another way to do this would be to add a new function 
`fwnode_remove_software_node_recursive` and just call that from 
`software_node_unregister_nodes`.

That said, I suppose just ordering the nodes so that children come 
before parents would also be fine. My thinking was just that accepting 
any node ordering is simpler.

Thanks,
Jordan
