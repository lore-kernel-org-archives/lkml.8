Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E6C4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB0024683
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582738535;
	bh=iIA7gnb4jhPzFqCYBQxKjl4iO0jNVn1njrEGIED4l1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=itoSsWzKwtiEzHjbd61kBzT+bX6LStNog6cSuaqWgsOQYc3vtJQQUw3+MG2idbl9O
	 Bs40/qs1scB89AJsriKY9+5UmN4zzsp1wMkxbuzFeF/kMHL+0ls+uBFj6ZyuMVliI6
	 dVaadzOOXEa5gS2IsZBamwce9OqHkQQ+AMiD8uhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgBZRfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgBZRfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:35:34 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 255B82467D;
        Wed, 26 Feb 2020 17:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582738533;
        bh=iIA7gnb4jhPzFqCYBQxKjl4iO0jNVn1njrEGIED4l1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=014tAPG6E3MZXvg7Cgw96bvKrLoXL2EjI+Vq1rOU6sXY9T/09Na+W+C1OtRl8NB5Q
         wHnqWw/E+SfJGTqYD7g4mkp36TOE6Vsfd22fw86LAz3JNQ4YO5FE8HE81DHfh5+F63
         TEg3mn2Qbarw4w3bynQnyhoaGJtFsVOFbwfmh5Q0=
Date:   Wed, 26 Feb 2020 18:35:31 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 09/10] x86/entry/entry_32: Route int3 through
 common_exception
Message-ID: <20200226173530.GD6075@lenoir>
References: <20200225213636.689276920@linutronix.de>
 <20200225220217.042369808@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225220217.042369808@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 10:36:45PM +0100, Thomas Gleixner wrote:
> int3 is not using the common_exception path for purely historical reasons,
> but there is no reason to keep it the only exception which is different.
> 
> Make it use common_exception so the upcoming changes to autogenerate the
> entry stubs do not have to special case int3.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
