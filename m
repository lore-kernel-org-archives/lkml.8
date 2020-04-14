Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7786AC352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8FF20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XVjLzIQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440208AbgDNQqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440191AbgDNQqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:46:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB92C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:46:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s63so9797902qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfOD7EaK+q8c2YJvX0sTcAqUjqr5njaCiuPjmWgtzBE=;
        b=XVjLzIQlg50ciqsr9sTLQNFTvqtjWPj89b4reQVp87HY70MgU6qtCnI06g0/UjM0o5
         S6NDv0r1wfCLsYiwTZTiIN+UtRJANnsd0AVCskqbzroLvq8PeuOLA5118M+f/vnSFWwe
         v6ibyCFvTITCVoYdE57RBP67j6ek5jImbPiyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfOD7EaK+q8c2YJvX0sTcAqUjqr5njaCiuPjmWgtzBE=;
        b=I7rEiFRCZIw6uorkbQ04/td50VZytyBNORw06JlYqrqnbaXGfiMg7GLGEVALhZzsOZ
         thbVJ+xfa7D0M3V3v4bvlKws5ZapjxgGDLKsDEVvphVnNYEGBlWOMW46Z6xPJfRsF6/S
         0wXXY1VLbCRnenmcmKi9lATyLmC2IH8xF82o0klpCyi6FdgQ19pgYVLSh9ZXVs5Pl6/M
         fUg+pava7EjBqsj9pJXhrT774O1ijOp/JezRJLiaBS5EFecbEy7Har7q3htMjCr+Fa1v
         dnh4qNxlcv7R6PPBKt6nKsExluir5CSapcVSHJHPeIqEgiDl8f8G+dakqbiBITA7HLf4
         3Fbw==
X-Gm-Message-State: AGi0PubWSDlXr6z+RAMWEOm4eOOxE9Q+3cKUKl7aOWAeATCGy1B8nalg
        xtDc2Ut8NZy4inYcoeabMpFD4cwZ0mQ=
X-Google-Smtp-Source: APiQypIfXCf6lh+lYp4/o4VrxsSIm0VxQBm9E2A0YcbszUwI4tLmjhp+zOZ+Cltj+6NgCPFDbsQiew==
X-Received: by 2002:a37:4a88:: with SMTP id x130mr22167091qka.247.1586882761118;
        Tue, 14 Apr 2020 09:46:01 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id x16sm10006898qts.0.2020.04.14.09.46.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 09:46:00 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id x66so13934507qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:46:00 -0700 (PDT)
X-Received: by 2002:a37:4284:: with SMTP id p126mr21309031qka.316.1586882759559;
 Tue, 14 Apr 2020 09:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200410162305.76638-1-mathewk@chromium.org> <c0e0c052-17bd-fea7-a4a8-07b4afbe56bd@collabora.com>
In-Reply-To: <c0e0c052-17bd-fea7-a4a8-07b4afbe56bd@collabora.com>
From:   Jett Rink <jettrink@chromium.org>
Date:   Tue, 14 Apr 2020 10:45:47 -0600
X-Gmail-Original-Message-ID: <CAK+PMK51SOH_61ci7zCEDHFJ9yiN=J8fYh2WFhj82=v4qYCV1Q@mail.gmail.com>
Message-ID: <CAK+PMK51SOH_61ci7zCEDHFJ9yiN=J8fYh2WFhj82=v4qYCV1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_ishtp: skip old cros_ec responses
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Mathew King <mathewk@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!


On Tue, Apr 14, 2020 at 10:24 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Jett and Mathew,
>
> Thank you for the patch
>
> On 10/4/20 18:23, Mathew King wrote:
> > From: Jett Rink <jettrink@chromium.org>
> >
> > The ISHTP layer can give us old responses that we already gave up on. We
> > do not want to interpret these old responses as the current response we
> > are waiting for.
> >
> > The cros_ish should only have one request in flight at a time. We send
> > the request and wait for the response from the ISH. If the ISH is too
> > slow to respond we give up on that request and we can send a new
> > request. The ISH may still send the response to the request that timed
> > out and without this we treat the old response as the response to the
> > current command. This is a condition that should not normally happen but
> > it has been observed with a bad ISH image. So add a token to the request
> > header which is copied into the response header when the ISH processes
> > the message to ensure that response is for the current request.
> >
> > Signed-off-by: Jett Rink <jettrink@chromium.org>
> > Signed-off-by: Mathew King <mathewk@chromium.org>
>
> Queued for 5.8
>
> > ---
> > v2: - Change from using id to token
> >     - Reword the commit message
> > ---
> >  drivers/platform/chrome/cros_ec_ishtp.c | 32 ++++++++++++++++++-------
> >  1 file changed, 23 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
> > index 93a71e93a2f1..e673a7f738fc 100644
> > --- a/drivers/platform/chrome/cros_ec_ishtp.c
> > +++ b/drivers/platform/chrome/cros_ec_ishtp.c
> > @@ -48,7 +48,8 @@ static const guid_t cros_ish_guid =
> >  struct header {
> >       u8 channel;
> >       u8 status;
> > -     u8 reserved[2];
> > +     u8 token;
> > +     u8 reserved;
> >  } __packed;
> >
> >  struct cros_ish_out_msg {
> > @@ -90,6 +91,7 @@ static DECLARE_RWSEM(init_lock);
> >   * data exceeds this value, we log an error.
> >   * @size: Actual size of data received from firmware.
> >   * @error: 0 for success, negative error code for a failure in process_recv().
> > + * @token: Expected token for response that we are waiting on.
> >   * @received: Set to true on receiving a valid firmware      response to host command
> >   * @wait_queue: Wait queue for host to wait for firmware response.
> >   */
> > @@ -98,6 +100,7 @@ struct response_info {
> >       size_t max_size;
> >       size_t size;
> >       int error;
> > +     u8 token;
> >       bool received;
> >       wait_queue_head_t wait_queue;
> >  };
> > @@ -162,6 +165,7 @@ static int ish_send(struct ishtp_cl_data *client_data,
> >                   u8 *out_msg, size_t out_size,
> >                   u8 *in_msg, size_t in_size)
> >  {
> > +     static u8 next_token;
> >       int rv;
> >       struct header *out_hdr = (struct header *)out_msg;
> >       struct ishtp_cl *cros_ish_cl = client_data->cros_ish_cl;
> > @@ -174,8 +178,11 @@ static int ish_send(struct ishtp_cl_data *client_data,
> >       client_data->response.data = in_msg;
> >       client_data->response.max_size = in_size;
> >       client_data->response.error = 0;
> > +     client_data->response.token = next_token++;
> >       client_data->response.received = false;
> >
> > +     out_hdr->token = client_data->response.token;
> > +
> >       rv = ishtp_cl_send(cros_ish_cl, out_msg, out_size);
> >       if (rv) {
> >               dev_err(cl_data_to_dev(client_data),
> > @@ -249,17 +256,23 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
> >
> >       switch (in_msg->hdr.channel) {
> >       case CROS_EC_COMMAND:
> > -             /* Sanity check */
> > -             if (!client_data->response.data) {
> > +             if (client_data->response.received) {
> >                       dev_err(dev,
> > -                             "Receiving buffer is null. Should be allocated by calling function\n");
> > -                     client_data->response.error = -EINVAL;
> > -                     goto error_wake_up;
> > +                             "Previous firmware message not yet processed\n");
> > +                     goto end_error;
> >               }
> >
> > -             if (client_data->response.received) {
> > +             if (client_data->response.token != in_msg->hdr.token) {
> > +                     dev_err_ratelimited(dev,
> > +                                         "Dropping old response token %d\n",
> > +                                         in_msg->hdr.token);
> > +                     goto end_error;
> > +             }
> > +
> > +             /* Sanity check */
> > +             if (!client_data->response.data) {
> >                       dev_err(dev,
> > -                             "Previous firmware message not yet processed\n");
> > +                             "Receiving buffer is null. Should be allocated by calling function\n");
> >                       client_data->response.error = -EINVAL;
> >                       goto error_wake_up;
> >               }
> > @@ -289,9 +302,10 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
> >               memcpy(client_data->response.data,
> >                      rb_in_proc->buffer.data, data_len);
> >
> > +error_wake_up:
> >               /* Set flag before waking up the caller */
> >               client_data->response.received = true;
> > -error_wake_up:
> > +
> >               /* Wake the calling thread */
> >               wake_up_interruptible(&client_data->response.wait_queue);
> >
> >
