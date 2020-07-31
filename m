Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913B9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7046A20829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Db2WsUck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbgGaG7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbgGaG7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:59:46 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED95C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 23:59:45 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id r197so2219478vkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 23:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Dzb4qikGnC7PJc3yHKTz13us3kdcfG1rOFTmBMSQwo=;
        b=Db2WsUckgXvkpgsukQSgRbIsZRyOiXhG1OVbXKRN6hIiui1861e4zH+ggX4jEwHPYF
         pgoAXPIpvfAzJMRJKP6I40Q9K57Qy3Dium732+ysCRaRsFi2BlHIL8gkvvA0EEh8sQ2f
         LXpKGuKYosVTw1N3Wxkw1kWP2nvyPFGmDMNAzIEsxfaGRFwsEVvAmU1vS2lHlprw29CC
         hKg2H7ZRwoRpCVQ/dvIXsKFYwhc/ozuGtWcizhaXRctAzBijm6v80RKksTXWCOlUdAlS
         lhvwVHyOABtVAdYK/CvtmV5dYzQINqOP9fbA3EuOgEP7ywoqx+IE8hQBoU+y5iy2Ocxt
         ELYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Dzb4qikGnC7PJc3yHKTz13us3kdcfG1rOFTmBMSQwo=;
        b=Yw4RpeyAC9K14shoG4CKPNidkEFU7Uy4a7VQMMG8ub5tav6E80k04icVvcRD1KMpFu
         1vaBsQuQ9rQdaGPRiGc1YCetbGbMBQ0cexPj91BAZZcP8WsWlzpctHlcbHq5xoSW09/n
         1nlN5qPvQMpIfl6EQQr6o1pajzzRvlRp0yFAJgCNNdFhOZLIRcxmoPfFFzzUw0SfiPaX
         TUuoK/WuKkrOzjgu0G9mjciOZA0lg7fT8s/ndhCq3sbZ9sFpoDA3U/FrNnR0iWDLH3DV
         NKG30QYB+I1TC4DuFhTJ5pcR9sMcCViOMKsk5TCekQedE2H2GD9KWQFmZqQjTaIxHqe/
         PwYg==
X-Gm-Message-State: AOAM532v66ahqZ0+nf//cmdooB0OaLhoXnEunYK0EisWWb4eG3SBK8Mv
        0hQnVzLMqCo4t7oNUQ1tjPpm/MD+pp0LNlq5fT1/Pg==
X-Google-Smtp-Source: ABdhPJz4xTSNBFzKm8MK/dWshaCLtJsQmyXj9v/1SQl7ouSkIU3MSRKmN2e3pzeqtSiN8SoMdvp33CGLgFgV3pEO9aU=
X-Received: by 2002:a1f:de81:: with SMTP id v123mr1704997vkg.92.1596178784465;
 Thu, 30 Jul 2020 23:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200730072531.3171984-1-badhri@google.com> <20200730123431.GO883641@kuha.fi.intel.com>
 <33bec771-7255-517f-fb5f-9c4e7320837d@roeck-us.net>
In-Reply-To: <33bec771-7255-517f-fb5f-9c4e7320837d@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 30 Jul 2020 23:59:08 -0700
Message-ID: <CAPTae5L8UGUqCg4h6BuGRk7_OH1HkXmoirACqzGKRhJfj6ZuHA@mail.gmail.com>
Subject: Re: [PATCH v4] usb: typec: tcpm: Migrate workqueue to RT priority for
 processing events
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for catching that !!

On Thu, Jul 30, 2020 at 9:05 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/30/20 5:34 AM, Heikki Krogerus wrote:
> > Hi,
> >
> > One more nitpick below...
> >
> > On Thu, Jul 30, 2020 at 12:25:31AM -0700, Badhri Jagan Sridharan wrote:
> >> @@ -4786,10 +4807,28 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
> >>      return PTR_ERR_OR_ZERO(port->psy);
> >>  }
> >>
> >> +static enum hrtimer_restart state_machine_timer_handler(struct hrtimer *timer)
> >> +{
> >> +    struct tcpm_port *port = container_of(timer, struct tcpm_port, state_machine_timer);
> >> +
> >> +    kthread_queue_work(port->wq, &port->state_machine);
> >> +    return HRTIMER_NORESTART;
> >> +}
> >> +
> >> +static enum hrtimer_restart vdm_state_machine_timer_handler(struct hrtimer *timer)
> >> +{
> >> +    struct tcpm_port *port = container_of(timer, struct tcpm_port, vdm_state_machine_timer);
> >> +
> >> +    kthread_queue_work(port->wq, &port->vdm_state_machine);
> >> +    return HRTIMER_NORESTART;
> >> +}
> >> +
> >>  struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
> >>  {
> >>      struct tcpm_port *port;
> >>      int err;
> >> +    /* Priority just lower than default irq thread priority */
> >> +    struct sched_param param = {.sched_priority = (MAX_USER_RT_PRIO / 2) + 1,};
> >
> > Move that outside the function and constify it:
> >
>
> Good catch. With this change applied:
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> >         static const struct sched_param param {
> >                 .shed_priority = (MAX_USER_RT_PRIO / 2) + 1,
>
> Caution: s/shed/sched/
>
> >         };
> >
> >>      if (!dev || !tcpc ||
> >>          !tcpc->get_vbus || !tcpc->set_cc || !tcpc->get_cc ||
> >
> > thanks,
> >
>
