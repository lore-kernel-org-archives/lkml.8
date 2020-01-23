Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468A4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F76A21569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579805774;
	bh=ntVLWfAQ4HN6TI0EcJB4auZ7w0f1L4NqXYySckaiR44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WGEp2I+wQ2vH+V9VxdBbiIkk+En0orblaXxlHJvvRsmpQBZEyuWrU+PrQUIf/Qbvz
	 btS4whZ+xiAIg4PQ3sWmcSmV7ElpJkKFtuSuuKIF+MvvaxapXgxoVBFG/0CFWDqZWv
	 Brwlqw5/PMfbDSgpKXZZc78joBkljUrvws+kOzio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAWS4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:56:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAWS4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:56:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C9922464;
        Thu, 23 Jan 2020 18:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579805772;
        bh=ntVLWfAQ4HN6TI0EcJB4auZ7w0f1L4NqXYySckaiR44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxpNMLpN+juRbN63ywA8YrYyxbcr5NlorR9Fc0aaadi3UqBC4eT0sF0OE5ZeYrBQi
         cDV8M/YXdywC01dAOolO2rFCg7Dhr9k8l2PFq16zFyo+kd9BuTmW0QJE9DLIN3zThk
         6YYsC6IONp+Qwc5p2ijMwlXR6j477W16aMKHAOfE=
Date:   Thu, 23 Jan 2020 19:56:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: hpet: Use flexible-array member
Message-ID: <20200123185609.GA2075008@kroah.com>
References: <20200120235326.GA29231@embeddedor.com>
 <20200123182545.GA1954152@kroah.com>
 <7bf963ff-94b1-7efe-747e-4153081d1947@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf963ff-94b1-7efe-747e-4153081d1947@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 12:46:42PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 1/23/20 12:25, Greg Kroah-Hartman wrote:
> > On Mon, Jan 20, 2020 at 05:53:26PM -0600, Gustavo A. R. Silva wrote:
> >> Old code in the kernel uses 1-byte and 0-byte arrays to indicate the
> >> presence of a "variable length array":
> >>
> >> struct something {
> >>     int length;
> >>     u8 data[1];
> >> };
> >>
> >> struct something *instance;
> >>
> >> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> >> instance->length = size;
> >> memcpy(instance->data, source, size);
> >>
> >> There is also 0-byte arrays. Both cases pose confusion for things like
> >> sizeof(), CONFIG_FORTIFY_SOURCE, etc.[1] Instead, the preferred mechanism
> >> to declare variable-length types such as the one above is a flexible array
> >> member[2] which need to be the last member of a structure and empty-sized:
> >>
> >> struct something {
> >>         int stuff;
> >>         u8 data[];
> >> };
> >>
> >> Also, by making use of the mechanism above, we will get a compiler warning
> >> in case the flexible array does not occur last in the structure, which
> >> will help us prevent some kind of undefined behavior bugs from being
> >> unadvertenly introduced[3] to the codebase from now on.
> >>
> >> [1] https://github.com/KSPP/linux/issues/21
> >> [2] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> >> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >> ---
> >>  drivers/char/hpet.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> >> index 9ac6671bb514..aed2c45f7968 100644
> >> --- a/drivers/char/hpet.c
> >> +++ b/drivers/char/hpet.c
> >> @@ -110,7 +110,7 @@ struct hpets {
> >>  	unsigned long hp_delta;
> >>  	unsigned int hp_ntimer;
> >>  	unsigned int hp_which;
> >> -	struct hpet_dev hp_dev[1];
> >> +	struct hpet_dev hp_dev[];
> > 
> > Are you sure the allocation size is the same again?  Much like the
> > n_hdlc patch was, I think you need to adjust the variable size here.
> > Maybe, it's a bit of a pain to figure out at a quick glance, I just want
> > to make sure you at least do look at that :)
> > 
> 
> Yep. The allocation thing was already handled almost a year ago by the
> following patch, and it didn't require to increase the size at that time:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=401c9bd10beef4b030eb9e34d16b5341dc6c683b

Great, thanks for verifying, I'll go queue this up now.

greg k-h
