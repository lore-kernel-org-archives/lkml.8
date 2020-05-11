Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3D0C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA5A2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="S+SiU7Jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgEKHfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 03:35:03 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:23170 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728014AbgEKHfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 03:35:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589182500; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=UCIjJvA6rgSGBFzjOKGYKOSkfNovydryhudZcq3rbrc=;
 b=S+SiU7JtBZJFEesdmrYSO3RYZ/kEexZRqFF1UCSNcuudihrjKFxTvcKGM+W5eUfR8fDdiRiy
 bvMoboT86LLQ/ropZn+YU0o446HDN6TxKvy6LHe1ymkd3lLMYaGLMUeHrlS2AE1O9vJW0f4a
 IJohCWrmRH5530alSRDspmTWj2g=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb90015.7fcd1109dd18-smtp-out-n03;
 Mon, 11 May 2020 07:34:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4278C433BA; Mon, 11 May 2020 07:34:45 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rananta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1FE4C433F2;
        Mon, 11 May 2020 07:34:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 May 2020 00:34:44 -0700
From:   rananta@codeaurora.org
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, andrew@daynix.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hvc: Fix data abort due to race in hvc_open
In-Reply-To: <77d889be4e0cb0e6e30f96199e2d843d@codeaurora.org>
References: <20200428032601.22127-1-rananta@codeaurora.org>
 <20200506094851.GA2787548@kroah.com>
 <98bbe7afabf48d8e8fe839fdc9e836a5@codeaurora.org>
 <20200510064819.GB3400311@kroah.com>
 <77d889be4e0cb0e6e30f96199e2d843d@codeaurora.org>
Message-ID: <a033c31f8d8bf121e2cfdabbca138c1a@codeaurora.org>
X-Sender: rananta@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-11 00:23, rananta@codeaurora.org wrote:
> On 2020-05-09 23:48, Greg KH wrote:
>> On Sat, May 09, 2020 at 06:30:56PM -0700, rananta@codeaurora.org 
>> wrote:
>>> On 2020-05-06 02:48, Greg KH wrote:
>>> > On Mon, Apr 27, 2020 at 08:26:01PM -0700, Raghavendra Rao Ananta wrote:
>>> > > Potentially, hvc_open() can be called in parallel when two tasks calls
>>> > > open() on /dev/hvcX. In such a scenario, if the
>>> > > hp->ops->notifier_add()
>>> > > callback in the function fails, where it sets the tty->driver_data to
>>> > > NULL, the parallel hvc_open() can see this NULL and cause a memory
>>> > > abort.
>>> > > Hence, serialize hvc_open and check if tty->private_data is NULL
>>> > > before
>>> > > proceeding ahead.
>>> > >
>>> > > The issue can be easily reproduced by launching two tasks
>>> > > simultaneously
>>> > > that does nothing but open() and close() on /dev/hvcX.
>>> > > For example:
>>> > > $ ./simple_open_close /dev/hvc0 & ./simple_open_close /dev/hvc0 &
>>> > >
>>> > > Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
>>> > > ---
>>> > >  drivers/tty/hvc/hvc_console.c | 16 ++++++++++++++--
>>> > >  1 file changed, 14 insertions(+), 2 deletions(-)
>>> > >
>>> > > diff --git a/drivers/tty/hvc/hvc_console.c
>>> > > b/drivers/tty/hvc/hvc_console.c
>>> > > index 436cc51c92c3..ebe26fe5ac09 100644
>>> > > --- a/drivers/tty/hvc/hvc_console.c
>>> > > +++ b/drivers/tty/hvc/hvc_console.c
>>> > > @@ -75,6 +75,8 @@ static LIST_HEAD(hvc_structs);
>>> > >   */
>>> > >  static DEFINE_MUTEX(hvc_structs_mutex);
>>> > >
>>> > > +/* Mutex to serialize hvc_open */
>>> > > +static DEFINE_MUTEX(hvc_open_mutex);
>>> > >  /*
>>> > >   * This value is used to assign a tty->index value to a hvc_struct
>>> > > based
>>> > >   * upon order of exposure via hvc_probe(), when we can not match it
>>> > > to
>>> > > @@ -346,16 +348,24 @@ static int hvc_install(struct tty_driver
>>> > > *driver, struct tty_struct *tty)
>>> > >   */
>>> > >  static int hvc_open(struct tty_struct *tty, struct file * filp)
>>> > >  {
>>> > > -	struct hvc_struct *hp = tty->driver_data;
>>> > > +	struct hvc_struct *hp;
>>> > >  	unsigned long flags;
>>> > >  	int rc = 0;
>>> > >
>>> > > +	mutex_lock(&hvc_open_mutex);
>>> > > +
>>> > > +	hp = tty->driver_data;
>>> > > +	if (!hp) {
>>> > > +		rc = -EIO;
>>> > > +		goto out;
>>> > > +	}
>>> > > +
>>> > >  	spin_lock_irqsave(&hp->port.lock, flags);
>>> > >  	/* Check and then increment for fast path open. */
>>> > >  	if (hp->port.count++ > 0) {
>>> > >  		spin_unlock_irqrestore(&hp->port.lock, flags);
>>> > >  		hvc_kick();
>>> > > -		return 0;
>>> > > +		goto out;
>>> > >  	} /* else count == 0 */
>>> > >  	spin_unlock_irqrestore(&hp->port.lock, flags);
>>> >
>>> > Wait, why isn't this driver just calling tty_port_open() instead of
>>> > trying to open-code all of this?
>>> >
>>> > Keeping a single mutext for open will not protect it from close, it will
>>> > just slow things down a bit.  There should already be a tty lock held by
>>> > the tty core for open() to keep it from racing things, right?
>>> The tty lock should have been held, but not likely across ->install() 
>>> and
>>> ->open() callbacks, thus resulting in a race between hvc_install() 
>>> and
>>> hvc_open(),
>> 
>> How?  The tty lock is held in install, and should not conflict with
>> open(), otherwise, we would be seeing this happen in all tty drivers,
>> right?
>> 
> Well, I was expecting the same, but IIRC, I see that the open() was 
> being
> called in parallel for the same device node.
> 
> Is it expected that the tty core would allow only one thread to
> access the dev-node, while blocking the other, or is it the client
> driver's responsibility to handle the exclusiveness?
Or is there any optimization going on where the second call doesn't go 
through
install(), but calls open() directly as the file was already opened by 
the first
thread?
>>> where hvc_install() sets a data and the hvc_open() clears it. 
>>> hvc_open()
>>> doesn't
>>> check if the data was set to NULL and proceeds.
>> 
>> What data is being set that hvc_open is checking?
> hvc_install sets tty->private_data to hp, while hvc_open sets it to
> NULL (in one of the paths).
>> 
>> And you are not grabbing a lock in your install callback, you are only
>> serializing your open call here, I don't see how this is fixing 
>> anything
>> other than perhaps slowing down your codepaths.
> Basically, my intention was to add a NULL check before accessing *hp in 
> open().
> The intention of the lock was to protect against this check.
> If the tty layer would have taken care of this, then perhaps there 
> won't be a
> need to check for NULL.
>> 
>> As an arument why this isn't correct, can you answer why this same 
>> type
>> of change wouldn't be required for all tty drivers in the tree?
>> 
> I agree, that if it's already taken care by the tty-core, we don't need 
> it here.
> Correct me if I'm wrong, but looks like the tty layer is allowing
> parallel accesses
> to open(),
>> thanks,
>> 
>> greg k-h
