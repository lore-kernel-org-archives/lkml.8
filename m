Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07637C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF100206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+wh5q8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgCHNTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 09:19:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40831 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgCHNTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 09:19:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id e26so6991728wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JtE0GdtEt7/HiG2oS0nuHmJGbnr3pvPyW/vanPbcLQY=;
        b=p+wh5q8+v+1S1wIMD6XHhhm0IIIn9o/fOEsKsNUx9IwB/p6NslaqBAkDbaa2J2Etv4
         0Cvsb1G9VPt3E5FxC+rx+H512jS68HQebfHiUaIIu1V0LaswF9bKAdJaw+vxa3K1YDO3
         hJTFGt6IqxLZQzdfxkbFFeD23dMhqeo3BYnEO5Hj3K5OiMqZhQPdtgW59H+2g9aQs9/Z
         IZzXMJsCgzP683xnoHaIqv2e/9C7ziDE4VWDe5/arSm3pQCNaOpULJEAn2lsf0FZL/kN
         sIxSqhi6PuiyI/Z8bcsLMGBVVvepneknq23z9p2PFepNl3tNJ64mgviFpVdn/A23qpA6
         /Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JtE0GdtEt7/HiG2oS0nuHmJGbnr3pvPyW/vanPbcLQY=;
        b=RIkwaeDNVL+e1uuGubt+39AAoaUp0n5apV1AsPwpU2Kb+RLdOx6H+dKjUaPJ51+sJ+
         C+yzU3LXCz9oDfL1FLhvor+dXn55JJBPdbcaHbad49MA9qDuCvKRG2y2rkmWn2JcFJOD
         0W9WlxB+N6UIzdsVluR6gbQmLb2soIRgtPSzwo6IO08ANZ/h0KPsujLB0gYqdUlEPWvI
         ApcbyIumlzUd6KlEZDlgrpWZrmM/27kNaypPxb2/t1oEoNYwS5lO9GBi2a2NeUoeVElj
         ck0B0Rt7MHM+xVB1q3CDxvNkXSDRpQGLBqEOsOD6xZCX8aDmgIyOS4Rs6TMdjSvkF6zW
         b8jg==
X-Gm-Message-State: ANhLgQ2RlL1Pb55IAoitGBHa3BabKeSq3mvreO0Mc6HDrQIJAfX/yeLG
        EV6Ug4WEWgDDSbhful8VpjA=
X-Google-Smtp-Source: ADFU+vsuKpMDH71NTKmQQEnEX3L/zLhoMcAfBF1HXCMjmeYM9g0hgt40yYxF3vJg8khYDT9VjNjOhA==
X-Received: by 2002:a1c:3241:: with SMTP id y62mr11004089wmy.66.1583673588266;
        Sun, 08 Mar 2020 06:19:48 -0700 (PDT)
Received: from kbp1-lhp-F74019 (a81-14-236-68.net-htp.de. [81.14.236.68])
        by smtp.gmail.com with ESMTPSA id a26sm22342748wmm.18.2020.03.08.06.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Mar 2020 06:19:47 -0700 (PDT)
Date:   Sun, 8 Mar 2020 15:19:44 +0200
From:   Yan Yankovskyi <yyankovskyi@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xen: Use evtchn_type_t as a type for event channels
Message-ID: <20200308131944.GA18740@kbp1-lhp-F74019>
References: <20200307134322.GA27756@kbp1-lhp-F74019>
 <d190793c-fe6b-263e-7793-ccd73f9ccad4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d190793c-fe6b-263e-7793-ccd73f9ccad4@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 02:41:44PM -0500, Boris Ostrovsky wrote:
> 
> 
> On 3/7/20 8:43 AM, Yan Yankovskyi wrote:
> > Make event channel functions pass event channel port using
> > evtchn_port_t type. It eliminates signed <-> unsigned conversion.
> >
> 
> 
> >  static int find_virq(unsigned int virq, unsigned int cpu)
> >  {
> >  	struct evtchn_status status;
> > -	int port, rc = -ENOENT;
> > +	evtchn_port_t port;
> > +	int rc = -ENOENT;
> >  
> >  	memset(&status, 0, sizeof(status));
> >  	for (port = 0; port < xen_evtchn_max_channels(); port++) {
> > @@ -962,7 +963,8 @@ EXPORT_SYMBOL_GPL(xen_evtchn_nr_channels);
> >  int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
> >  {
> >  	struct evtchn_bind_virq bind_virq;
> > -	int evtchn, irq, ret;
> > +	evtchn_port_t evtchn = xen_evtchn_max_channels();
> > +	int irq, ret;
> >  
> >  	mutex_lock(&irq_mapping_update_lock);
> >  
> > @@ -990,7 +992,6 @@ int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
> >  			if (ret == -EEXIST)
> >  				ret = find_virq(virq, cpu);
> >  			BUG_ON(ret < 0);
> > -			evtchn = ret;
> 
> 
> This looks suspicious. What would you be passing to
> xen_irq_info_virq_setup() below?

Right, this line should be preserved.

> I also think that, given that this patch is trying to get types in
> order, find_virq() will need more changes: it is supposed to return
> evtchn_port_t. But then it also wants to return a (signed) error.
 
As we don't care which error we got during find_virq call, we can just
return 0 in case of error, and port number otherwise. Port 0 is never
valid, so this approach can work for the other functions as well.
On the other hand, passing port using pointer and returning actual
error message, as it's done in xenbus_alloc_evtchn(), sounds like a
better approach overall. What do you think?

> >  		}
> >  
> >  		ret = xen_irq_info_virq_setup(cpu, irq, evtchn, virq);
> > @@ -1019,7 +1020,7 @@ static void unbind_from_irq(unsigned int irq)
> >  	mutex_unlock(&irq_mapping_update_lock);
> >  }
> >  
> 
> 
> 
> >  {
> >  	struct evtchn_close close;
> >  	int err;
> > @@ -423,7 +423,7 @@ int xenbus_free_evtchn(struct xenbus_device *dev, int port)
> 
> And why not here, especially since you updated format?

I missed it.

> >  
> >  	err = HYPERVISOR_event_channel_op(EVTCHNOP_close, &close);
> >  	if (err)
> > -		xenbus_dev_error(dev, err, "freeing event channel %d", port);
> > +		xenbus_dev_error(dev, err, "freeing event channel %u", port);
> >  
> >  	return err;
> >  }
> 
> 
> 
> >  
> > diff --git a/include/xen/interface/event_channel.h b/include/xen/interface/event_channel.h
> > index 45650c9a06d5..cf80e338fbb0 100644
> > --- a/include/xen/interface/event_channel.h
> > +++ b/include/xen/interface/event_channel.h
> > @@ -220,7 +220,7 @@ struct evtchn_expand_array {
> >  #define EVTCHNOP_set_priority    13
> >  struct evtchn_set_priority {
> >  	/* IN parameters. */
> > -	uint32_t port;
> > +	evtchn_port_t port;
> 
> This definition comes from Xen so I think it needs to be fixed there first.

Will be done.

> > --- a/drivers/xen/xenbus/xenbus_client.c
> > +++ b/drivers/xen/xenbus/xenbus_client.c
> > @@ -391,7 +391,7 @@ EXPORT_SYMBOL_GPL(xenbus_grant_ring);
> >   * error, the device will switch to XenbusStateClosing, and the error will be
> >   * saved in the store.
> >   */
> > -int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port)
> > +int xenbus_alloc_evtchn(struct xenbus_device *dev, evtchn_port_t *port)
> 
> Right. But then why is the declaration in include/xen/xenbus.h (at the
> very end of the patch) different?
> 
> >  {
> >  	struct evtchn_alloc_unbound alloc_unbound;
> >  	int err;
> > @@ -414,7 +414,7 @@ EXPORT_SYMBOL_GPL(xenbus_alloc_evtchn);
> >  /**
> >   * Free an existing event channel. Returns 0 on success or -errno on error.
> >   */
> > -int xenbus_free_evtchn(struct xenbus_device *dev, int port)
> > +int xenbus_free_evtchn(struct xenbus_device *dev, evtchn_port_t port)
> 
> Here too.
> 
> >  	uint32_t priority;
> >  };
> >  
> > diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> > index 89a889585ba0..4f35216064ba 100644
> > --- a/include/xen/xenbus.h
> > +++ b/include/xen/xenbus.h
> > @@ -218,8 +218,8 @@ int xenbus_unmap_ring(struct xenbus_device *dev,
> >  		      grant_handle_t *handles, unsigned int nr_handles,
> >  		      unsigned long *vaddrs);
> >  
> > -int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port);
> > -int xenbus_free_evtchn(struct xenbus_device *dev, int port);
> > +int xenbus_alloc_evtchn(struct xenbus_device *dev, unsigned int *port);
> > +int xenbus_free_evtchn(struct xenbus_device *dev, unsigned int port);
> 
> These.

I was reluctant with inclusion of event channel header into xenbus.
Will be fixed.

> -boris
> 
