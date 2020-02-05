Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0284CC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5A32082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580937524;
	bh=QMhz+7e00RCmyYOltDlwhumaKg1yWLzr33A3QyUuuf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a8/SaXS99yX9zwagf+dv06v854n45B9xEBH4weF60pN/InmIPK+7xFtfa2RpJFeAH
	 LPVvARV5tv/exfEEhd+/xGOFN9vst3+TRV+b2mFTjR+glHWwKl2fXbvzFIvhBTikqc
	 N8mzBgRo+4nzht3+ohr6hEWhp0X4q/KtJ1+ZpUP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBEVSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:18:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgBEVSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:18:41 -0500
Received: from localhost (unknown [193.117.204.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 191DC2082E;
        Wed,  5 Feb 2020 21:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580937521;
        bh=QMhz+7e00RCmyYOltDlwhumaKg1yWLzr33A3QyUuuf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEZpJZ1IHojRHvcxZHovij4sNzGsPKYmm9DiTM2JYopwLkCzNUvZolklBQ4EInKLX
         RG2YM+zHZy7xp9YnzEzWVVYgJIyKMfYFqn4X90ph6bEw5cRVym7KDwplndYk/cI5vd
         yJrptSfDQ9V2IW3Vn2qsYv+zg5cM29TPA1/vYS5w=
Date:   Wed, 5 Feb 2020 21:18:39 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v5 1/1] usb: gadget: add raw-gadget interface
Message-ID: <20200205211839.GE1399643@kroah.com>
References: <cover.1579007786.git.andreyknvl@google.com>
 <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com>
 <87ftfv7nf0.fsf@kernel.org>
 <CAAeHK+wwmis4z9ifPAnkM36AnfG2oESSLAkKvDkuAa0QUM2wRg@mail.gmail.com>
 <87a7637ise.fsf@kernel.org>
 <CAAeHK+zNuqwmHG4NJwZNtQHizdaOpriHxoQffZHMffeke_hsGQ@mail.gmail.com>
 <87tv4556ke.fsf@kernel.org>
 <CAAeHK+zE6N3W-UQ7yjrSkbfwGCBmd0cTv=z7LKNRa2Er1KMPew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zE6N3W-UQ7yjrSkbfwGCBmd0cTv=z7LKNRa2Er1KMPew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 06:25:25PM +0100, Andrey Konovalov wrote:
> Re licensing comments, do I need to change anything after all?

Nope, that part is fine, thanks.

greg k-h
