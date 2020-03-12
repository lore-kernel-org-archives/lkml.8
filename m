Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91BBC0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A0120736
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=labbott.name header.i=@labbott.name header.b="IrxrAn2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbgCLCUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:20:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33850 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbgCLCUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:20:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id f3so4267716qkh.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 19:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jCSRmMZ7Fjxj81Mc6fS91ZlgijJ9jLMjcHnF8aGvMfY=;
        b=IrxrAn2lC0Y50vHyiWYFoQ9u18uXXUV1z1riXDA63o7lQPyuLph4VPmd4jsbPNc0rJ
         Ysp6Lllv9gDCcpcrzVRaXlivC5wS1RqqwRW4zXjUmef0dekGgiFx7jzCev44c4n5RSMc
         O1y9okdAYmCmkeUMCIeCQiWqVdqV7aR24DlL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jCSRmMZ7Fjxj81Mc6fS91ZlgijJ9jLMjcHnF8aGvMfY=;
        b=pI5GSHt82vPxIAp6nje6xmNx7p9+QhjAgr5ROyceQPyCKouF/4DAxRDoOcgchdKauO
         305hIngkF0z8aXE94S7vPi08+t9Lbl5QRME4hpo8MqUi5XBccn3t1GfRPBe1doSLqQOG
         EIupuuOQDNt/0rVqapKIUNO8y7o6ZDRmrzBQVnUqH8qqBq3w7LwPpKU5EWF0yXzaqEKm
         V7ciyAdDYrkE0a9jdzuHZlu1D/oGmBqIeOUI2Wc/WFA1CPN2ZmRonbF2vZ8ItsHIlgHd
         HcEHM+YhvgbYVRqi/ls0p5K1raC5ILNtyD9/xfT3tqrkmowFSWTv/AFh0bVl9NchMxN3
         ZHhQ==
X-Gm-Message-State: ANhLgQ157TDz9S1JkyNRxMBJQFEqtvBcZkmQG8LJLpIk7Adybj7XoAAa
        /ItsOlEnphbwAdYrNGquZbpySI8Vy+g=
X-Google-Smtp-Source: ADFU+vsS267Bl8NJ1nuETfZPZBQUqJb1eg1FckARm5JitNbSA7CuVyV2rs1TFy8/9a22ZhQ+dM7M3A==
X-Received: by 2002:a05:620a:109a:: with SMTP id g26mr5767857qkk.166.1583979616041;
        Wed, 11 Mar 2020 19:20:16 -0700 (PDT)
Received: from Lauras-MBP.fios-router.home (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id s56sm11138726qtk.9.2020.03.11.19.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 19:20:15 -0700 (PDT)
Subject: Re: [Ksummit-discuss] Linux Foundation Technical Advisory Board
 Elections -- Change to charter
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     tech-board-discuss@lists.linuxfoundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
 <20200312003436.GF1639@pendragon.ideasonboard.com>
From:   Laura Abbott <laura@labbott.name>
Message-ID: <750770eb-1fd4-73e1-da8a-f1247e31e7d8@labbott.name>
Date:   Wed, 11 Mar 2020 22:20:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312003436.GF1639@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(speaking only for myself)

On 3/11/20 8:34 PM, Laurent Pinchart wrote:
> Hi Laura,
> 
> On Wed, Mar 11, 2020 at 08:19:46PM -0400, Laura Abbott wrote:
>> On behalf of the Linux Foundation Technical Advisory Board (TAB), I
>> would like to announce the following changes to our charter, available
>> at https://wiki.linuxfoundation.org/tab/start
>>
>> - Line 2b that previously read "All members shall be elected by a vote
>> amongst all invitees of the Linux Kernel Summit." is changed to "All
>> members shall be elected by a vote amongst all attendees of the Linux
>> Kernel Summit."
>>
>> This clarifies that kernel summit is no longer invite only.
> 
> This is a good clarification, no issue with it.
> 
>> - Under meetings and membership, the following line is added
>> "The TAB, at its discretion, may set criteria to allow for absentee
>> voting for those who are unable to attend the Linux Kernel Summit."
> 
> This is however a bit more problematic. I understand the intent, which I
> believe is good, but it would make ballot stuffing very easy. At the
> same time I understood it will not be an easy task to set clear written
> rules that wouldn't be over complex and would still allow reaching the
> end goal of expanding the election to the whole community through
> electronic voting. I'm afraid I don't have a solution to propose to this
> problem at this time.
> 

Thanks for the feedback.

Yes, this is a lot of the discussion we've been having. This is
definitely something we are carefully considering and intend to work
through. I, personally, want to err on the side of letting more
people participate but it's very hard to figure out what's a realistic
threat model. The TAB has a charter but it only works because the
community trusts us. If we were to get vote flooded by 10000 sock
puppets and elect 5 people who the majority of the community doesn't
trust, what impact could they actually have?

The charter also has this line: "The TAB is being formed at the
discretion of the Board. The Board alone may decide to terminate the TAB
in its sole discretion; provided however, that the Board or its
authorized officer shall first consult the TAB Chair." So in theory,
the TAB could be abolished. Would this actually happen? I would
really hope not but it's worth pointing out that there is a possible
solution for election edge cases, even if it's a very destructive one.
On the other hand, maybe I've actually provided a stronger argument for
why we really need to be careful about avoiding ballot box stuffing
if the only option is to burn it all down.

Also in case anyone in the community is worried we're trying to rush
this through in case of conference cancellations, this (really) has
been in discussion for the past few months. The way this is change is
worded the TAB also has the option of not allowing absentee voting, so
if in the unlikely event we don't come up with acceptable terms we will
be going with the existing voting procedures and not allowing absentee
voting.

Thanks,
Laura

>> For those who like diff form, this looks like
>>
>> diff --git a/charter b/charter
>> index 45816d7..70b2e56 100644
>> --- a/charter
>> +++ b/charter
>> @@ -4,7 +4,8 @@
>>        - Promote and Support the programmes with which the TAB is charged
>> to the wider Linux and Open Source Communities.
>>      - Meetings and Membership.
>>        - The TAB consists of ten voting members.
>> -    - All members shall be elected by a vote amongst all invitees of
>> the Linux Kernel Summit.
>> +    - All members shall be elected by a vote amongst all attendees of
>> the Linux Kernel Summit.
>> +    - The TAB, at its discretion, may set criteria to allow for
>> absentee voting for those who are unable to attend the Linux Kernel Summit.
>>        - Self nominations for the election shall be accepted from any
>> person, via email to the TAB mailing list, up until the time of the
>> election.
>>        - Membership of the TAB shall be for a term of 2 years with
>> staggered 1-year elections.
>>        - The TAB shall elect a Chair and Vice-Chair of the TAB from
>> amongst their members to serve a renewable 1 year term.
>>
>>
>> This change is intended to be a follow on to last year's changes to vote
>> electronically instead of using paper ballots
>> (see
>> https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-July/006582.html)
>> We will be announcing criteria for absentee voting at a later date.
>>
>> If you have any questions, feel free to speak up here or privately at
>> tab@lists.linuxfoundation.org.
> 
