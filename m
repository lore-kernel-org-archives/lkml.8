Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E770C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F68420639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IfM7a9JV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHXSem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHXSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:34:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70042C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=y5s9jJbL8Rdnw0BzneLpjPMhR5Y8x3gmv/6FKWKQqbA=; b=IfM7a9JVU/JJCyFN+zP5G7WS8O
        v3EwoMXZWsUSzwGrBMwfqMZ0tIY6iS+J/gCfWqjgdWhkOLlMNjD7CiKGrQeNYaFFBS4UQhEGs/aIT
        6f/JYvHURS98AxH8ida6PLrU+rcmQuj4Q04WxtpyMg6S1EsjQPwkBBmYXszvZM15bbEoRtiGKw6i2
        31etz6UIFDsU37Jie0ANCMou5VNPJzn55sElZcljfhftGzpCx3wj62cST8Qutrg+mD4/vPFsQaRKC
        i7od+AVevkO3fO1EXHNWwLiniqwHmbq7NDuQr8S4TBHSxjW9UXrehWRltpA4r76ZpCIuhjf/r91Go
        e7uNpriA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAHIg-00017M-7J; Mon, 24 Aug 2020 18:34:34 +0000
Subject: Re: [PATCH v2 3/9] iommu/ioasid: Introduce ioasid_set APIs
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.pan.linux@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>, Wu Hao <hao.wu@intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200824182848.GB3210689@myrica>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1be98989-fab3-f9e4-cbd6-cf72a67dc5f1@infradead.org>
Date:   Mon, 24 Aug 2020 11:34:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824182848.GB3210689@myrica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/20 11:28 AM, Jean-Philippe Brucker wrote:
>> +/**
>> + * struct ioasid_set - Meta data about ioasid_set
>> + * @type:	Token types and other features
> nit: doesn't follow struct order
> 
>> + * @token:	Unique to identify an IOASID set
>> + * @xa:		XArray to store ioasid_set private IDs, can be used for
>> + *		guest-host IOASID mapping, or just a private IOASID namespace.
>> + * @quota:	Max number of IOASIDs can be allocated within the set
>> + * @nr_ioasids	Number of IOASIDs currently allocated in the set

 * @nr_ioasids: Number of IOASIDs currently allocated in the set

>> + * @sid:	ID of the set
>> + * @ref:	Reference count of the users
>> + */
>>  struct ioasid_set {
>> -	int dummy;
>> +	void *token;
>> +	struct xarray xa;
>> +	int type;
>> +	int quota;
>> +	int nr_ioasids;
>> +	int sid;
>> +	refcount_t ref;
>> +	struct rcu_head rcu;
>>  };


-- 
~Randy

