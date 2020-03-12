Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C79C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408DB206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="C7lZa6U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbgCLAem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:34:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57686 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbgCLAem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:34:42 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 15F385F;
        Thu, 12 Mar 2020 01:34:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583973280;
        bh=xVvqG1ilYiWhWwmbyFkn7l+XF4P8qC3OqQBrk7ztgyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7lZa6U+hQvEnIP/0+1gRtCOkaMcSTiPMZsBtYMDd/A6y8tPt4HpYsLxUwuLOkJRD
         DdvsPtsBvOB8nZMQPWzW/CboNp9t1QOExsJOTGc/fPv8DD/3I1G6bDNXWD4OdP6Rt2
         EaQ4unIZlB1UnE+fFFAtDsqURHSXbzLZrNDcX7E4=
Date:   Thu, 12 Mar 2020 02:34:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Laura Abbott <laura@labbott.name>
Cc:     tech-board-discuss@lists.linuxfoundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Ksummit-discuss] Linux Foundation Technical Advisory Board
 Elections -- Change to charter
Message-ID: <20200312003436.GF1639@pendragon.ideasonboard.com>
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

On Wed, Mar 11, 2020 at 08:19:46PM -0400, Laura Abbott wrote:
> On behalf of the Linux Foundation Technical Advisory Board (TAB), I
> would like to announce the following changes to our charter, available
> at https://wiki.linuxfoundation.org/tab/start
> 
> - Line 2b that previously read "All members shall be elected by a vote
> amongst all invitees of the Linux Kernel Summit." is changed to "All
> members shall be elected by a vote amongst all attendees of the Linux
> Kernel Summit."
> 
> This clarifies that kernel summit is no longer invite only.

This is a good clarification, no issue with it.

> - Under meetings and membership, the following line is added
> "The TAB, at its discretion, may set criteria to allow for absentee
> voting for those who are unable to attend the Linux Kernel Summit."

This is however a bit more problematic. I understand the intent, which I
believe is good, but it would make ballot stuffing very easy. At the
same time I understood it will not be an easy task to set clear written
rules that wouldn't be over complex and would still allow reaching the
end goal of expanding the election to the whole community through
electronic voting. I'm afraid I don't have a solution to propose to this
problem at this time.

> For those who like diff form, this looks like
> 
> diff --git a/charter b/charter
> index 45816d7..70b2e56 100644
> --- a/charter
> +++ b/charter
> @@ -4,7 +4,8 @@
>       - Promote and Support the programmes with which the TAB is charged 
> to the wider Linux and Open Source Communities.
>     - Meetings and Membership.
>       - The TAB consists of ten voting members.
> -    - All members shall be elected by a vote amongst all invitees of 
> the Linux Kernel Summit.
> +    - All members shall be elected by a vote amongst all attendees of 
> the Linux Kernel Summit.
> +    - The TAB, at its discretion, may set criteria to allow for 
> absentee voting for those who are unable to attend the Linux Kernel Summit.
>       - Self nominations for the election shall be accepted from any 
> person, via email to the TAB mailing list, up until the time of the 
> election.
>       - Membership of the TAB shall be for a term of 2 years with 
> staggered 1-year elections.
>       - The TAB shall elect a Chair and Vice-Chair of the TAB from 
> amongst their members to serve a renewable 1 year term.
> 
> 
> This change is intended to be a follow on to last year's changes to vote
> electronically instead of using paper ballots
> (see 
> https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-July/006582.html)
> We will be announcing criteria for absentee voting at a later date.
> 
> If you have any questions, feel free to speak up here or privately at
> tab@lists.linuxfoundation.org.

-- 
Regards,

Laurent Pinchart
