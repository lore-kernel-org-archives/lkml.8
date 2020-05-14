Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816C0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF5A206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgENR2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:28:21 -0400
Received: from namei.org ([65.99.196.166]:58990 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgENR2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:28:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 04EHS8QU026941;
        Thu, 14 May 2020 17:28:08 GMT
Date:   Fri, 15 May 2020 03:28:08 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jeremy Cline <jcline@redhat.com>
cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Frank Ch . Eigler" <fche@redhat.com>
Subject: Re: [PATCH RESEND] lockdown: Allow unprivileged users to see lockdown
 status
In-Reply-To: <20200514140546.826698-1-jcline@redhat.com>
Message-ID: <alpine.LRH.2.21.2005150327590.26489@namei.org>
References: <20200220151738.1492852-1-jcline@redhat.com> <20200514140546.826698-1-jcline@redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020, Jeremy Cline wrote:

> A number of userspace tools, such as systemtap, need a way to see the
> current lockdown state so they can gracefully deal with the kernel being
> locked down. The state is already exposed in
> /sys/kernel/security/lockdown, but is only readable by root. Adjust the
> permissions so unprivileged users can read the state.
> 
> Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
> Cc: Frank Ch. Eigler <fche@redhat.com>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

