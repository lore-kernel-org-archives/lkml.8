Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41B1C3B190
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841A321734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgBMXZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:25:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59957 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBMXZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 18:25:30 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1j2NrM-00021t-T8; Thu, 13 Feb 2020 23:25:29 +0000
Subject: Re: [PATCH] Documentation/process: Swap out the ambassador for
 Canonical
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200213214842.21312-1-tyhicks@canonical.com>
 <20200213231607.GA3925051@kroah.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <ea91eec6-a1be-807b-32e7-acfa36071599@canonical.com>
Date:   Thu, 13 Feb 2020 15:25:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213231607.GA3925051@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/20 3:16 PM, Greg Kroah-Hartman wrote:
> On Thu, Feb 13, 2020 at 09:48:42PM +0000, Tyler Hicks wrote:
>> John Johansen will take over as the process ambassador for Canonical
>> when dealing with embargoed hardware issues.
> 
> Can I get an ack from John to "prove" he is ok with this horrible task?  :)
> 

sure take away the plausible deniability ;)
