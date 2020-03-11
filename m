Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39450 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCKQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:43:07 -0400
Subject: Re: [EXTERNAL] Re: [PATCH v4 2/4] power_supply: Add additional health
 properties to the header
To: Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sandeep Patil <sspatil@android.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@android.com>
References: <20200116175039.1317-1-dmurphy@ti.com>
 <20200116175039.1317-3-dmurphy@ti.com>
 <20200117010658.iqs2zpwl6bsomkuo@earth.universe>
 <20200306235548.GA187098@google.com>
 <20200310213050.si7gcr2wbmjgr7jf@earth.universe>
 <de919edb-79b3-82ec-f55c-31a127d6c751@ti.com>
From: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <66b2ac86-8513-b540-8a2c-c2ebef4124dd@ti.com>
Date: Wed, 11 Mar 2020 11:43:00 -0500
MIME-Version: 1.0
In-Reply-To: <de919edb-79b3-82ec-f55c-31a127d6c751@ti.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sebastian

On 3/11/20 6:29 AM, Dan Murphy wrote:
> Sebastian
>
> On 3/10/20 4:30 PM, Sebastian Reichel wrote:
>> Hi Sandeep,
>>
>> On Fri, Mar 06, 2020 at 03:55:48PM -0800, Sandeep Patil wrote:
>>> On Fri, Jan 17, 2020 at 02:06:58AM +0100, Sebastian Reichel wrote:
>>>> Hi,
>>>>
>>>> On Thu, Jan 16, 2020 at 11:50:37AM -0600, Dan Murphy wrote:
>>>>> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
>>>>>
>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>> ---
>>>> Looks good. But I will not merge it without a user and have comments
>>>> for the driver.
>>> Android has been looking for these properties for a while now [1].
>>> It was added[2] when we saw that the manufacturers were implementing 
>>> these
>>> properties in the driver. I didn't know the properties were absent 
>>> upstream
>>> until yesterday. Somebody pointed out in our ongoing effort to make 
>>> sure
>>> all core kernel changes that android depends on are present upstream.
>>>
>>> I think those values are also propagated in application facing APIs in
>>> Android (but I am not sure yet, let me know if that's something you 
>>> want
>>> to find out).
>>>
>>> I wanted to chime in and present you a 'user' for this if that helps.
>> With user I meant an upstream kernel driver, which exposes the
>> values. But thanks for the pointer. This should be mentioned in
>> the patch description, also the fact that the status values are
>> directly taken from JEITA spec.
>
> I mentioned the JEITA in the cover letter but I guess you would like 
> the description in the commit message as well
>
> Dan
>
>
I have added a note mentioning that the properties are taken from the 
JEITA spec in the commit message and listing the bq2515x_charger driver 
as a user. I am waiting for feedback on my other patches in the series 
before sending you v5 patches.

Ricardo

