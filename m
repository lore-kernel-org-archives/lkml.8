Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BFBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AE920678
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgFADCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 23:02:13 -0400
Received: from kernel.crashing.org ([76.164.61.194]:53942 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgFADCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:02:13 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 05131rec003219
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 31 May 2020 22:01:57 -0500
Message-ID: <940c0e0575bec1cbbc015bbda5b7da7009cdc392.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 07/18] nitro_enclaves: Init misc device providing the
 ioctl interface
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Alexander Graf <graf@amazon.de>
Cc:     Andra Paraschiv <andraprs@amazon.com>,
        linux-kernel@vger.kernel.org,
        Anthony Liguori <aliguori@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
Date:   Mon, 01 Jun 2020 13:01:52 +1000
In-Reply-To: <20200526222402.GC179549@kroah.com>
References: <20200525221334.62966-1-andraprs@amazon.com>
         <20200525221334.62966-8-andraprs@amazon.com>
         <20200526065133.GD2580530@kroah.com>
         <72647fa4-79d9-7754-9843-a254487703ea@amazon.de>
         <20200526123300.GA2798@kroah.com>
         <59007eb9-fad3-9655-a856-f5989fa9fdb3@amazon.de>
         <20200526131708.GA9296@kroah.com>
         <29ebdc29-2930-51af-8a54-279c1e449a48@amazon.de>
         <20200526222402.GC179549@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-27 at 00:24 +0200, Greg KH wrote:
> > Would you want random users to get the ability to hot unplug CPUs from your
> > system? At unlimited quantity? I don't :).
> 
> A random user, no, but one with admin rights, why not?  They can do that
> already today on your system, this isn't new.

So I agree with you that a module parameter sucks. I disagree on the
ioctl :)

This is the kind of setup task that will probably end up being done by
some shell script at boot time based on some config file. Being able to
echo something in a sysfs file which will parse the standard-format CPU
list using the existing kernel functions to turn that into a cpu_mask
makes a lot more sense than having a binary interface via an ioctl
which will require an extra userspace program for use by the admin for
that one single task.

So sysfs is my preference here.

Another approach would be configfs, which would provide a more flexible
interface to potentially create multiple "CPU sets" that could be given
to different users or classes of users etc... but that might be pushing
it, I don't know.

Cheers,
Ben.


