Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB30C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5227624655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgAWJvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:51:02 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:49978 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgAWJvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:51:02 -0500
Received: from [109.168.11.45] (port=37326 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1iuZ8d-000AMk-Sr; Thu, 23 Jan 2020 10:50:59 +0100
Subject: Re: [PATCH 23/26] docs: i2c: old-module-parameters: fix internal
 hyperlink
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
 <20200105225012.11701-23-luca@lucaceresoli.net>
 <20200122111625.6685b606@endymion>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <59e5698f-b4df-ca71-a60f-aebdac56873f@lucaceresoli.net>
Date:   Thu, 23 Jan 2020 10:50:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200122111625.6685b606@endymion>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 22/01/20 11:16, Jean Delvare wrote:
> On Sun,  5 Jan 2020 23:50:09 +0100, Luca Ceresoli wrote:
>> Use ReST syntax so that a proper hyperlink is generated.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>  Documentation/i2c/old-module-parameters.rst | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/Documentation/i2c/old-module-parameters.rst b/Documentation/i2c/old-module-parameters.rst
>> index 78a6950e5763..0503d2f0b127 100644
>> --- a/Documentation/i2c/old-module-parameters.rst
>> +++ b/Documentation/i2c/old-module-parameters.rst
>> @@ -12,8 +12,7 @@ address), "force" (to forcibly attach the driver to a given device) and
>>  With the conversion of the I2C subsystem to the standard device driver
>>  binding model, it became clear that these per-module parameters were no
>>  longer needed, and that a centralized implementation was possible. The new,
>> -sysfs-based interface is described in the documentation file
>> -"instantiating-devices", section "Method 4: Instantiate from user-space".
>> +sysfs-based interface is described in :doc:`instantiating-devices`.
> 
> I object to removing the reference to the section. I think this is
> saving the reader some time so it is valuable.

I agree, re-added in v2.

-- 
Luca
