Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A574C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60506206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591343704;
	bh=F5ckDxBoTfzTlsdoPDm6iMTBJW8h6mJ8lDlune7vUxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X7xVuuBLdDRBupUMlSzY9r+YeNZL02BTd78lLCxWarEzEM+6NI+pEtbyUYAF6g0Mm
	 q/27hi6E30PtwHKQSkx5rGyPZFxtt8OuSdK44KJNSIZEk7TENXBW1BKtYvLduCxjvp
	 z19iVJ78x6hEzGBT/x0xEf3/bbUInNvMtbvZF8w0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgFEHzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgFEHzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:55:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DEB206E6;
        Fri,  5 Jun 2020 07:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591343701;
        bh=F5ckDxBoTfzTlsdoPDm6iMTBJW8h6mJ8lDlune7vUxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEu42y6aSWTCJvNfoCSag8QnhYCSoQ4EaYh7cp2+gT8XhrHKyPEoUuoEotdiuVT1s
         uomaHTj67y2S71PQxLmaGd3yF8mHnOxY9cMs4m0ETkKBd9XHpg8sneCg+UQHrWfC7w
         nD0gxUpx3hgPg/b0ddvC/dJ3QUttev3LAhWgtXjA=
Date:   Fri, 5 Jun 2020 09:54:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jordan Hand <jorhand@linux.microsoft.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] software node: recursively unregister child swnodes
Message-ID: <20200605075459.GB2209311@kroah.com>
References: <20200604193623.16946-1-jorhand@linux.microsoft.com>
 <20200604201523.GA1308830@kroah.com>
 <c6150824-60d3-11ad-ba1a-e75d6a7a916e@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6150824-60d3-11ad-ba1a-e75d6a7a916e@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 01:57:01PM -0700, Jordan Hand wrote:
> On 6/4/20 1:15 PM, Greg Kroah-Hartman wrote:
> > On Thu, Jun 04, 2020 at 12:36:23PM -0700, jorhand@linux.microsoft.com wrote:
> > > From: Jordan Hand <jorhand@linux.microsoft.com>
> > > 
> > > If a child swnode is unregistered after it's parent, it can lead to
> > > undefined behavior.
> > 
> > Crashing the system is not really "undefined" :)
> 
> Fair point :)
> 
> > 
> > > When a swnode is unregistered, recursively free it's children to avoid
> > > this condition.
> > 
> > Are you sure?  Why would you be unregistering a child after it's parent?
> > Why not just do not do that?
> > 
> 
> The main motivation for doing this was to support
> `software_node_unregister_nodes` so that the passed list of nodes does not
> need to be ordered in any particular way.
> 
> I suppose another way to do this would be to add a new function
> `fwnode_remove_software_node_recursive` and just call that from
> `software_node_unregister_nodes`.
> 
> That said, I suppose just ordering the nodes so that children come before
> parents would also be fine. My thinking was just that accepting any node
> ordering is simpler.

Right now, the way the driver model and sysfs/kobjects work is that all
objects must be removed in child-first order.  The problem of your
change where you want to try to remove the devices in parent-first order
is that you do not really know if you still have a reference to a child
device somewhere else, which would prevent this all from happening
correctly, right?

So if you "know" it is safe to drop a child, that's great, and expected.
Don't work to make  this one tiny user of the kobjects (which I'm still
not quite sure why they are kobjects and not devices), do things in a
different way from the rest of the kernel without a strong reason to do
so.

thanks,

greg k-h
