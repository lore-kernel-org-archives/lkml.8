Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A930CC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B37F2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgAURb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:31:27 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:44791 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729147AbgAURb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:31:26 -0500
Received: from [109.168.11.45] (port=53424 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1itxN5-0003hq-Bi; Tue, 21 Jan 2020 18:31:23 +0100
Subject: Re: [PATCH 15/26] docs: i2c: smbus-protocol: enable kernel-doc
 function syntax
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
 <20200105225012.11701-15-luca@lucaceresoli.net>
 <20200120154444.7c1d3863@endymion>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <211da679-154f-15e3-52d3-a24d50c526cf@lucaceresoli.net>
Date:   Tue, 21 Jan 2020 18:31:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120154444.7c1d3863@endymion>
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

On 20/01/20 15:44, Jean Delvare wrote:
> On Sun,  5 Jan 2020 23:50:01 +0100, Luca Ceresoli wrote:
>> Hyperlinks from function names are not generated in headings. Move them in
>> the plain text so they are rendered as clickable hyerlinks.
> 
> typo: hyperlinks

Ok.

>>
>> While there also remove an unneeded colon in a heading.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>  Documentation/i2c/smbus-protocol.rst | 64 ++++++++++++++++++----------
>>  1 file changed, 42 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/i2c/smbus-protocol.rst b/Documentation/i2c/smbus-protocol.rst
>> index 10c4a989982c..997945e90419 100644
>> --- a/Documentation/i2c/smbus-protocol.rst
>> +++ b/Documentation/i2c/smbus-protocol.rst
>> @@ -62,8 +62,10 @@ This sends a single bit to the device, at the place of the Rd/Wr bit::
>>  Functionality flag: I2C_FUNC_SMBUS_QUICK
>>  
>>  
>> -SMBus Receive Byte:  i2c_smbus_read_byte()
>> -==========================================
>> +SMBus Receive Byte
>> +==================
>> +
>> +Implemented by i2c_smbus_read_byte()
> 
> In file i2c-protocol.rst, the wording used is:
> 
> This corresponds to i2c_transfer().
> 
> For consistency, can we settle for "Implemented by foo()" everywhere?

Good point. For v2 I added a new patch to use "Implemented by" also in
i2c-protocol.rst.

Thanks.

By extrapolation I guess you want to review the few remaining patches.
Correnct? In this case I'd wait for that before sending out v2.

-- 
Luca
