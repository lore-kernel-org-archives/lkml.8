Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EA7C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9894C22522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgAWJvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:51:36 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:45194 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728925AbgAWJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:51:32 -0500
Received: from [109.168.11.45] (port=37336 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1iuZ98-000AeN-2k; Thu, 23 Jan 2020 10:51:30 +0100
Subject: Re: [PATCH 15/26] docs: i2c: smbus-protocol: enable kernel-doc
 function syntax
To:     Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>
Cc:     linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
 <20200105225012.11701-15-luca@lucaceresoli.net>
 <20200120154444.7c1d3863@endymion>
 <211da679-154f-15e3-52d3-a24d50c526cf@lucaceresoli.net>
 <20200122152608.40f7c90c@endymion> <20200122153747.GA21343@ninjato>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <37504278-2fea-f894-542c-c0a4f142eb9e@lucaceresoli.net>
Date:   Thu, 23 Jan 2020 10:51:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200122153747.GA21343@ninjato>
Content-Type: text/plain; charset=windows-1252
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

Hi,

On 22/01/20 16:37, Wolfram Sang wrote:
> On Wed, Jan 22, 2020 at 03:26:08PM +0100, Jean Delvare wrote:
>> On Tue, 21 Jan 2020 18:31:23 +0100, Luca Ceresoli wrote:
>>> Good point. For v2 I added a new patch to use "Implemented by" also in
>>> i2c-protocol.rst.
>>
>> BTW... I don't know how Wolfram feels about it, but I don't think
>> documentation changes need to be split to such fine-grained patches.
> 
> I don't mind too much. I think for a first version, fine grained can
> make review more easy. Maybe the second version could be less patches.
> Yet for me, since patchwork can handle series of patches, the amount
> doesn't matter too much. I am super happy that Luca did the work and you
> did the review!

I initially split this work in fine-grained patches for better reviewing
and also because some of the changes were not expected in the beginning:
while working at an improvement I noticed an unrelated one was needed.
But I agree the result is quite awkward. Coalescing some of them now
would be painful, so I'm sending v2 as is. But I'm tackling the
remaining sections later, and I'm going to do that work in a smaller
number of patches.

-- 
Luca
