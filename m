Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D941C35E0C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F85920CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgBYQoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:44:25 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:35367 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729536AbgBYQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:44:25 -0500
Received: from [109.168.11.45] (port=34196 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1j6dJm-00DP57-MU; Tue, 25 Feb 2020 17:44:22 +0100
Subject: Re: [DT-OVERLAY PATCH] of: overlay: print the offending node name on
 fixup failure
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200225104223.30891-1-luca@lucaceresoli.net>
 <CAMuHMdVuk_BcFH16eBQYeQxREAF9VPz+R_sBKQpG0jQ8JDLn0w@mail.gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <85a2e5a3-1872-d1db-5eb7-0f02265220a3@lucaceresoli.net>
Date:   Tue, 25 Feb 2020 17:44:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVuk_BcFH16eBQYeQxREAF9VPz+R_sBKQpG0jQ8JDLn0w@mail.gmail.com>
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

Hi Geert,

thanks for the very prompt review!

On 25/02/20 12:10, Geert Uytterhoeven wrote:
> Hi Luca,
> 
> On Tue, Feb 25, 2020 at 11:42 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>> When a DT overlay has a fixup node that is not present in the base DT
>> __symbols__, this error is printed:
>>
>>   OF: resolver: overlay phandle fixup failed: -22
>>   create_overlay: Failed to create overlay (err=-22)
>>
>> which does not help much in finding the node that caused the problem.
>>
>> Add a debug print with the name of the fixup node that caused the
>> error. The new output is:
>>
>>   OF: resolver: node gpio9 not found in base DT, fixup failed
>>   OF: resolver: overlay phandle fixup failed: -22
>>   create_overlay: Failed to create overlay (err=-22)
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> Thanks for your patch!
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
>> NOTE: this patch is not for mainline!
> 
> Why not?

Because I'm dumb. As I'm using the non-mainlined configfs interface I
tend to consider the entire overlay code as non-mainlined too. Sending
v2 without this comment.

>> --- a/drivers/of/resolver.c
>> +++ b/drivers/of/resolver.c
>> @@ -321,8 +321,11 @@ int of_resolve_phandles(struct device_node *overlay)
>>
>>                 err = of_property_read_string(tree_symbols,
>>                                 prop->name, &refpath);
>> -               if (err)
>> +               if (err) {
>> +                       pr_err("node %s not found in base DT, fixup failed",
>> +                              prop->name);
>>                         goto out;
>> +               }
>>
>>                 refnode = of_find_node_by_path(refpath);
>>                 if (!refnode) {
> 
> Probably you want to print a helpful message here, too?

I'm doing even more. In v2 I added a specific error message for each
error path that does not have one yet, and removed the generic message
at the end.

-- 
Luca
