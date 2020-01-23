Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA70C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225002253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgAWJvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:51:13 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:45973 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgAWJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:51:13 -0500
Received: from [109.168.11.45] (port=37328 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1iuZ8p-000AWa-HL; Thu, 23 Jan 2020 10:51:11 +0100
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
 <211da679-154f-15e3-52d3-a24d50c526cf@lucaceresoli.net>
 <20200122124859.52ceac75@endymion>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <9e5b28f4-ec75-7398-1c57-562978ececfe@lucaceresoli.net>
Date:   Thu, 23 Jan 2020 10:51:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200122124859.52ceac75@endymion>
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

On 22/01/20 12:48, Jean Delvare wrote:
> On Tue, 21 Jan 2020 18:31:23 +0100, Luca Ceresoli wrote:
>> By extrapolation I guess you want to review the few remaining patches.
>> Correnct? In this case I'd wait for that before sending out v2.
> 
> Yes, and I'm just done with it. Sorry it took so long but I was doing
> it as a background task as my work schedule allowed.

No problem at all, it has been a background task for me as well! Thanks
again for the patient work. V2 will be out soon with the many precious
improvements you suggested.

> One last thing you may want to fix: there's one occurrence of "stop
> bit" left in Documentation/i2c/writing-clients.rst.

Thanks, added.

-- 
Luca
