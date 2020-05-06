Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF016C47247
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 910A120735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aL5FzqiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgEFCyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgEFCyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:54:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2127CC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 19:54:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z1so288272pfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 19:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iNwWeuzlGPXoXK4GNyvwbVYZ9LLoZChVLx7D4DsWylg=;
        b=aL5FzqiABLNCmFvp+94bRF+U0Nlvn6CNStusRuSmKyM+HdmFua+oFccMrdt49/jOA8
         8WMbmKPGv5OkUVtEsLkYMehr3w852ABWEPqmvETeGubdq8l+EYRjCaN5DUWYfbol1+LS
         Q2lZKEYVrA0aw0VWmbmGuOpVGrivVsKuCzy8ED4fMDvAvdDa24wvp+DfJfYUn1hXAKlh
         YFVCH8Ll9Xh04U2H7A4kWe/HxiIsNQpNeXumE/23MhVJUQdw/nrtDDb10gv3+A/pPHpD
         K3DvxVj7itgSm4bQc3LiZJRgGjUXU2GWplLEpScXuBv4u5B8gMnPt2mwwdvfqhvEkK0B
         6k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iNwWeuzlGPXoXK4GNyvwbVYZ9LLoZChVLx7D4DsWylg=;
        b=D4SpzFvfgrogZ49erhHEhzcaHUMNZmLPyecFiCxB+FhJUFflgl9mJoW98EqDp9O/sR
         gC1kT9DYQpKoi/ThRB5oFaCqLU4n6D8Y5FC+c5JPTt7E1/ViG9dYAmfWyh9Q0mJuT3tJ
         j34wd/HXpBb9tvpgLbZSNAkZFtXhS2C3nKrey4uOF/Hz5X7pCrW2f13sqfy3DkpSNhl8
         OmTmXtk9kGzWTA0SWZ07J0hjR4CNmgCmYftxOoeHuJTie8FpZOOSZFEemT7CguHs7LhO
         A3h1oS1UlW6IOp7dobx+o+xUG1yPMKaMXWM0i3GZluMIdVfL1tqF2la5PvnOBwhEbB8A
         7BNg==
X-Gm-Message-State: AGi0PuY5A/8X6rnf3eWUNPYNnSlC0JE87IkOER/M8mb90GIpw+cdNEMs
        hFfvYUJxhEukahcbZZnpBCsi8A==
X-Google-Smtp-Source: APiQypKcyaPzuciLG7kJV3sDoFLAmtwbp6gkFuFyfiiecNEG178Y5T+SVdknhc1X4TVEHMFsx5bQJg==
X-Received: by 2002:a63:c241:: with SMTP id l1mr5399240pgg.42.1588733648445;
        Tue, 05 May 2020 19:54:08 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id bo19sm3177345pjb.26.2020.05.05.19.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 19:54:07 -0700 (PDT)
Date:   Tue, 5 May 2020 19:54:04 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        xiang xiao <xiaoxiang781216@gmail.com>
Subject: Re: [PATCH v7 2/2] tty: add rpmsg driver
Message-ID: <20200506025404.GA1302550@yoga>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
 <20200324170407.16470-3-arnaud.pouliquen@st.com>
 <20200324205210.GE119913@minitux>
 <4f5e6dd0-5deb-8036-0a94-eb7055744f35@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5e6dd0-5deb-8036-0a94-eb7055744f35@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25 Mar 09:57 PDT 2020, Arnaud POULIQUEN wrote:

> Hi Bjorn,
> 
> On 3/24/20 9:52 PM, Bjorn Andersson wrote:
> > On Tue 24 Mar 10:04 PDT 2020, Arnaud Pouliquen wrote:
> > [..]
> >> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> >> index 020b1cd9294f..c2465e7ebc2a 100644
> >> --- a/drivers/tty/Makefile
> >> +++ b/drivers/tty/Makefile
> >> @@ -34,5 +34,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
> >>  obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
> >>  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
> >>  obj-$(CONFIG_VCC)		+= vcc.o
> >> +obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
> >>  
> >>  obj-y += ipwireless/
> >> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
> > [..]
> >> +static struct rpmsg_device_id rpmsg_driver_tty_id_table[] = {
> >> +	{ .name	= TTY_CH_NAME_RAW },
> >> +	{ .name	= TTY_CH_NAME_WITH_CTS},
> > 
> > I still don't like the idea that the tty devices are tied to channels by
> > fixed names.
> 
> This point has been discussed with Xiang, he has the same kind of requirement. 
> My proposal here is to do this in two steps. First a fixed name, then
> in a second step we can extend the naming using the implementation proposed
> by Mathieu Poirier:
> 
> [1]https://lkml.org/lkml/2020/2/12/1083
> 
> Is this patch could answer to your requirement?
> 
> if requested i can I can integrate the Mathieu's patch in this patchset.
>  
> > 
> > This makes the driver unusable for communicating with any firmware out
> > there that provides tty-like data over a channel with a different name -
> > such as modems with channels providing an AT command interface (they are
> > not named "rpmsg-tty-raw").
> 
> I'm not fixed on the naming, any proposal is welcome.
> If we use the patch [1], could be renamed 
> "rpmsg-tty". then for AT command could be something like "rpmsg-tty-at"
> 
> But here seems we are speaking about service over TTY and not over RPMsg.
> 
> > 
> > I also fail to see how you would distinguish ttys when the firmware
> > provides more than a single tty - e.g. say you have a modem-like device
> > that provides an AT command channel and a NMEA stream.
> 
> Today it is a limitation. In fact this limitation is the same for all RPMsg
> devices with multi instance.
> The patch [1] will allow to retrieve the instance by identifying
> the service device name in /sys/class/tty/ttyRPMSG<X>/device/name
> 
> > 
> > 
> > These are the reasons why drivers/rpmsg/rpmsg_char registers a "control
> > device", from which you can spawn new char devices. As I've said before,
> > I really think the same approach should be taken for ttys - perhaps by
> > just extending the rpmsg_char to allow it to create tty devices in
> > addition to the "packet based" char device?
> > 
> I'm not very familiar with the rpmsg_char so please correct me if i'm wrong:
> 
> The rpmsg_char exposes to userland an interface to manage rpmsg channels
> (relying on a char device). This interface offers the  possibility to create
> new channels/endpoints and send/received related messages. 
>  
> Thus, the application declares the RPMsg channels which is bound if they matches
> with the remote processor channel (similar behavior than a kernel rpmsg driver).
> There is no constrain on the service once same service is advertised by remote
> firmware.
> 
> In addition, a limitation of the rpmsg_char device is that it needs to be
> associated with an existing device, as example the implementation in qcom_smd
> driver.
> 

Correct, the rpmsg_char control device must be associated with a
transport instance, e.g. a virtio rpmsg instance sitting on a
remoteproc. This is necessary in order to be able to tie the dynamically
created rpmsg_char endpoints (i.e. the thing that is similar to your tty
devices) to a particular transport/remoteproc..

The reason why qcom_smd needs to be involved is because of the problem
that I want the control device to appear without depending on particular
channels being exposed by the firmware.

> If i try to figure out how to implement TTY using the rpmsg_char:
> I should create a rpmsg_char dev in the rpmsg tty driver. Then application
> will create channels related to its service. But in this case
> how to ensure that channels created are related to the TTY service?  
> 

My proposal/wish is that 1) rpmsg_char is implemented for virtio/rpmsg,
so that the control device is registered as virtio rpmsg is initiated
and 2) that rpmsg_char is extended to allow creating tty devices in
addition to the existing interface (if the existing read/write interface
isn't enough).

> 
> I would also expect to manage RPMsg TTY such as a generic TTY: without
> extra interface and auto mounted as an USB TTY. this means that the
> /dev/ttyRMPSGx are created automatically at remote firmware startup
> (without any application action). For instance a generic application 
> (e.g. minicom) could control an internal remote processor such as
> an external processor through a TTY link. 
> 

And that's not possible using the two-stage approach rpmsg_char takes,
instead I use udev rules to invoke the ioctl on the control device.

The benefit is that the design of the firmware is not tied to the design
of the Linux system.

> Then we have also similar RPMsg driver for I2C and SPI virtual link. So extend
> the rpmsg_char to support TTY seems not a good solution for long terms. 
> 

What do you mean with this? Are you saying that running tty over rpmsg
over SPI is a bad idea?

> For these reasons i would prefer to have a specific driver. And found a solution
> to allow user to differentiate the TTY instances.
> 
> Anyway I am very interesting in having more details of an implementation relying
> on rpmsg_char if you still thinking that is the good approach here.
> 

I do think it's a good idea to decouple the system design on the Linux
side from the naming of channels provided by the firmware.

Regards,
Bjorn

> Thanks for your comments, 
> Arnaud
> 
> > Regards,
> > Bjorn
> > 
