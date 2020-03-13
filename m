Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F74C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40562076D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oKzyYuG0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U507xCj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgCMKIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:08:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34883 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbgCMKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:07:59 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id AB0A02267C;
        Fri, 13 Mar 2020 06:07:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 13 Mar 2020 06:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=1CNs5YOEikvzf5Ve+M+whn5X2VE
        UXw/yeljzd20doog=; b=oKzyYuG0nE5rQApCstTP3rrsOhRLi6g2BAzOcv2GbUt
        6nJQziROsDjz/u2k8KwFdAQGhNodSP0nXoJ0M/9JfwkGbBKFX7PezinBdVD3lnk+
        H0jSVrSLLFS+IuhiPT3rbz4DtSwAHKw3vrx44txOrhb2/AnmwbTkz/wM/0afymJd
        mRgooQR8/Z4DO7I+cXftXd/X9dVWTD64pfrAB5ZHKaEBXOdT2DotZpghcEmSXc44
        n6eXfGXVs7h49zpfcLtH8bjpGqfv7gaofHg7Nlcz8Xf3eutSsIBkqBBQpG11X1j6
        V5M7BlzvFVlBMOk4MvLSQys8qV2pBFD4p+US/uItayA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=1CNs5Y
        OEikvzf5Ve+M+whn5X2VEUXw/yeljzd20doog=; b=U507xCj43LbXREWkBgtvAE
        K/N9PAKkHfCjSgInWeTEiz9zfZY6pchrc1UaOtZTWe5qsD8nVaX5uZhMG3mnkOJF
        dm3bh+kzkN/BPYmbQqzdznwivrtC77S8DgQft2Scf103x3dol9WQZvD1VXSludKP
        JHJReKk4EC8edLEvFDucFJon215OiWocs9ECBFCNUspsGdrvnpsrM+0TZpzV7pNQ
        S+lMCH+9WF4/KXzMuWLV9rsGjq+bxKxJzidia3Sh4CEiN5cR6JYLd/yOi5wGe91L
        wBVRg4MG983JJw5tCxDPinVN9B2+NwWauidJDqn0LHtCtBVCoTu+ZDb+hw+RJEWA
        ==
X-ME-Sender: <xms:fVtrXmmIdaGsVuDHtiHGJ1IrjbxilhL5iJIpXCkP2TI87h83ozCzuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvjedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecukfhppeekfedrkeeirdekledruddtjeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:fVtrXlXCXN4IYT-OQN6zTAOlzrK0ozQEpTjN8h3Pc7rO5PYZ3_uhWA>
    <xmx:fVtrXqsyF2oaW8LL8Qk0b8Dy0Xfyx9n_jUV_AEd-KXMt5O6s6-8j5A>
    <xmx:fVtrXoo-u1Jxf9iIAGLB3YYhdmSJIGrHKA-pjGBZITsJ7hcdlI3W7Q>
    <xmx:fltrXqVPbU5sFuR30KFOlIJLS1yttH_Gp8oDZQGu2jdTafKhPYac-g>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 72D343280059;
        Fri, 13 Mar 2020 06:07:57 -0400 (EDT)
Date:   Fri, 13 Mar 2020 11:07:55 +0100
From:   Greg KH <greg@kroah.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] Linux Foundation
 Technical Advisory Board Elections -- Change to charter
Message-ID: <20200313100755.GA2161605@kroah.com>
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
 <20200312003436.GF1639@pendragon.ideasonboard.com>
 <MWHPR13MB0895E133EC528ECF50A22100FDFD0@MWHPR13MB0895.namprd13.prod.outlook.com>
 <20200313031947.GC225435@mit.edu>
 <87d09gljhj.fsf@intel.com>
 <20200313093548.GA2089143@kroah.com>
 <24c64c56-947b-4267-33b8-49a22f719c81@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24c64c56-947b-4267-33b8-49a22f719c81@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 10:41:57AM +0100, Vlastimil Babka wrote:
> On 3/13/20 10:35 AM, Greg KH wrote:
> >> Not that I'm saying there's an easy solution, but obviously kernel.org
> >> account is not as problem free as you might think.
> > 
> > We are not saying it is "problem free", but what really is the problem
> > with it?
> 
> IIUC there is no problem for its current use, but it would be rather restrictive
> if it was used as the only criterion for being able to vote for TAB remotely.

Given that before now, there has not be any way to vote for the TAB
remotely, it's less restrictive :)

These are "baby steps" we are taking here, to try to allow for remote
voting.  We are not saying this is the end-all-be-all solution, but you
have to give Laura credit for coming up with this as "better than
nothing" which is what has been the case for the past decade or so.

thanks,

greg k-h
