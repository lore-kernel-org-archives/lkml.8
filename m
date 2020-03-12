Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBC1C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049B6206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=labbott.name header.i=@labbott.name header.b="NNrUXuA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCLW6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:58:51 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:37782 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgCLW6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:58:51 -0400
Received: by mail-qt1-f176.google.com with SMTP id l20so5944547qtp.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 15:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dk3L/+5tmSg8tFJvvcXXWBuwuWvbWcVQihQHFRntHW8=;
        b=NNrUXuA3zH1/qGmp2fXsA18RnT434FdrUYosUAnjUU19VTN2HleoY57BystuHr9Xrm
         zo1oJGG9cYhimAvB8zIAHz4rJ150AKVZEDVU0CS1lnEpjLaFM5OuEek3pUdjjko5OGy9
         H9ZBT87VEZceTBBEp763ANpRKGC4fUBigj+r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dk3L/+5tmSg8tFJvvcXXWBuwuWvbWcVQihQHFRntHW8=;
        b=kphMeszmlws7auB45STHM8fh03RgKcm6iVClvxfRwO7GIwsrjr1YHBUe7QJd4fXA3o
         lrnFUyfXKZ+SI9XKnr34FQfOXx8jD8iVoeG8u+8Ovzi7I+/HM1xauQ4NlaanvKx3/28o
         0QDRY/+TQLEvHVpa671SnqE+hBHoERHASERE6fHXcDyUzV5l5MjEn4p+DECwAZGNvCSP
         34MkyAfEbFhfVGkelJZ65HQhHt36vhczU+s9BKfQZmAytjYEYE5LRWyCDjCjkxGcvZSG
         ecZHWzHXzO9d3k9n6ExBjvyBdee70PE1zJX7/y7WLnruoDyvOVb/QM8MI0GBRFI3kcto
         hXhw==
X-Gm-Message-State: ANhLgQ1S+pFG80Sv5kaarmTM0TaP/nbcX/DMt6uNXHejDg3XbC17WkkQ
        a55ibCO7ysaj1vlog9Un7MKDKIOzMUc=
X-Google-Smtp-Source: ADFU+vvexg2dmePLYL1jff9r/ch5AsR5XOURVjASlZiQnFtqaWMCHaxppl6V/txhNOCy9Gt/9V+e0g==
X-Received: by 2002:ac8:47cc:: with SMTP id d12mr3719471qtr.234.1584053928443;
        Thu, 12 Mar 2020 15:58:48 -0700 (PDT)
Received: from [192.168.1.168] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id x11sm14330050qkf.67.2020.03.12.15.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 15:58:48 -0700 (PDT)
Subject: Re: [Ksummit-discuss] Linux Foundation Technical Advisory Board
 Elections -- Change to charter
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
 <20200312003436.GF1639@pendragon.ideasonboard.com>
 <MWHPR13MB0895E133EC528ECF50A22100FDFD0@MWHPR13MB0895.namprd13.prod.outlook.com>
From:   Laura Abbott <laura@labbott.name>
Message-ID: <e932f9db-b06d-b4bb-d1ca-755cc54347c2@labbott.name>
Date:   Thu, 12 Mar 2020 18:58:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <MWHPR13MB0895E133EC528ECF50A22100FDFD0@MWHPR13MB0895.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/20 5:28 PM, Bird, Tim wrote:
>> -----Original Message-----
>> From:  Laurent Pinchart
>>
>> Hi Laura,
>>
>> On Wed, Mar 11, 2020 at 08:19:46PM -0400, Laura Abbott wrote:
>>> On behalf of the Linux Foundation Technical Advisory Board (TAB), I
>>> would like to announce the following changes to our charter, available
>>> at https://urldefense.proofpoint.com/v2/url?u=https-3A__wiki.linuxfoundation.org_tab_start&d=DwICAg&c=fP4tf--
>> 1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4cc&r=rUvFawR4KzgZu1gSN5tuozUn7iTTP0Y-INWqfY8MsF0&m=rEcpcrRVZ-R-
>> msxXCoATt2eqeJ0slEmwjZvSIsW2FnA&s=uCuhAV3NJJQ8ZD7FRbWtcW1p_3-DDKj2EsqssXv_hm0&e=
>>>
>>> - Line 2b that previously read "All members shall be elected by a vote
>>> amongst all invitees of the Linux Kernel Summit." is changed to "All
>>> members shall be elected by a vote amongst all attendees of the Linux
>>> Kernel Summit."
>>>
>>> This clarifies that kernel summit is no longer invite only.
>>
>> This is a good clarification, no issue with it.
>>
>>> - Under meetings and membership, the following line is added
>>> "The TAB, at its discretion, may set criteria to allow for absentee
>>> voting for those who are unable to attend the Linux Kernel Summit."
>>
>> This is however a bit more problematic. I understand the intent, which I
>> believe is good, but it would make ballot stuffing very easy. At the
>> same time I understood it will not be an easy task to set clear written
>> rules that wouldn't be over complex and would still allow reaching the
>> end goal of expanding the election to the whole community through
>> electronic voting. I'm afraid I don't have a solution to propose to this
>> problem at this time.
> 
> I agree with Laurent.  I'm not sure how to solve this problem, but
> I think you need something to indicate the voter approval policy
> besides "the TAB will decide it, and can change it when they like".
> 
> I suppose the pool of voters has been decided historically by the Kernel
> Summit invitation committee.  Some randomness was introduced by
> allowing voting by attendees from whatever event the Linux Foundation
> co-located with the Kernel Summit.  I think in practical terms,
> this means that recently the voting pool was self-selected (somewhat), but
> was skewed towards people who could travel, or had employer support.
> But in any event, the selection of the voting pool was done by people outside
> the TAB (or at least not necessarily inside the TAB), and without any eye towards
> skewing the election results.  That is, I don't think the kernel summit invitation
> committee, or the LF event staff, ever considered TAB voting in their KS attendee
> selection or event pairing choices.
> 
> I don't think that the current TAB would do anything wacky here.  And I suspect
> it's probably not a huge concern even for future TABs whose constitution we don't
> know yet. I do think, however, it would be better to have a written policy
> for the voting eligibility, that the TAB members can't change on a whim.
>   -- Tim
>   

(my own opinion again)

We intentionally wanted to keep it vague to avoid having to change the
charter every time we wanted to tweak the absentee voting requirements.
This is because while everyone is in favor of absentee voting in theory
there were concerns about trying to get the numbers right.

I'd argue that the way the charter is currently written the TAB
members can really change the election on a whim. The wording "All
members shall be elected by a vote amongst all invitees of the Linux
Kernel Summit" basically says nothing about how the vote is conducted.
The TAB does run the election and the community has trusted that we
set up proctors who aren't up for election and that we are using a
voting procedure that is actually fair as opposed to, say, voting
proportional to lines of code removed last year. I don't think this
is necessarily a _good_ situation since it could be easily abused
but I also think that absentee voting falls into the same category
of trusting the TAB to not come up with some arbitrary voting method
designed to get the outcome they want.

Maybe the real question is if the community would rather see all
election procedures specified explicitly rather than just placing
trust in the TAB.

Thanks,
Laura
