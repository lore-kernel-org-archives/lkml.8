Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7DEC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980CE2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584104739;
	bh=g5w22YsBnXA3tJ7GiCEWMSp8fKyae5t0PtEULq1PwZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hJxMEhJUiBn6FtSU7aq4WB3NKhtElm5vxqu0SZlnkYbDWPyDL6qZRPlAR0TRX6qMt
	 hwKSZTJL4iLqpcJqBidWRPAd0fqPOfL0PxvRXiAEIGoHGyc355D8TIBWBsDt9Ltovo
	 ee7s5ce5HOAArqojixuaem75YSX7dgI5IBprDxq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCMNFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgCMNFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:05:38 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20BD520724;
        Fri, 13 Mar 2020 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584104737;
        bh=g5w22YsBnXA3tJ7GiCEWMSp8fKyae5t0PtEULq1PwZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5cRqMylfvpZ5+ItbTy3OywUOyRXwOExSRxjFEEoZ0CtNoYt/T+COEom+ufdqH5SZ
         FzY0uGG2cGJCh/L8yvBNUZpO8syfbHI4gqB+r+md/k67HBzmKyqS7HUeOuWgNqrvpq
         OUudYWRnt4bCaFXRtXlb+xx1h7YYC+CI3UyFjnaQ=
Date:   Fri, 13 Mar 2020 09:05:36 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Greg KH <greg@kroah.com>, "Bird, Tim" <Tim.Bird@sony.com>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] Linux Foundation
 Technical Advisory Board Elections -- Change to charter
Message-ID: <20200313130536.GD1349@sasha-vm>
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
 <20200312003436.GF1639@pendragon.ideasonboard.com>
 <MWHPR13MB0895E133EC528ECF50A22100FDFD0@MWHPR13MB0895.namprd13.prod.outlook.com>
 <20200313031947.GC225435@mit.edu>
 <87d09gljhj.fsf@intel.com>
 <20200313093548.GA2089143@kroah.com>
 <877dzolf7n.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <877dzolf7n.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 12:30:20PM +0200, Jani Nikula wrote:
>On Fri, 13 Mar 2020, Greg KH <greg@kroah.com> wrote:
>There is no way of knowing whether you're eligible to vote until you
>apply for a kernel.org account and either get approved or rejected.
>
>The current "obvious" requirement levels are not obvious to me. How many
>contributions is enough? Is everyone in MAINTAINERS eligible, or do you
>have to be a high-profile maintainer/developer? What is a high-profile
>developer? How many people in the web of trust must you have met in
>person?

Personally, I think that our definition of who can vote should be "any
member of our community", but it's not practical, right?

This process will take years, and each year I would expect us to
increase the voting pool by a significant amount. Maybe we should focus
too much on what restrictions are in affect in the current year, but
rather on trying to learn how well these restrictions worked and which
of them we can lift.

-- 
Thanks,
Sasha
