Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3559CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B82820748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cSghd0A1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgGJUeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgGJUen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:34:43 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77466C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:34:43 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id rk21so7441204ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/SBX7F0TUuVX6qnc8J+wosE+QUcqZiPheTHOsrFz+o=;
        b=cSghd0A1bHl6W8BQItpavDDiPVX9ofld8ObVhrg13LiaUthO66J/KJplp2qR3dzsMZ
         /u7c/45w7w7s73JYiydlitSF//6ydNly6eZdccTZaDdszRaimsFMYdgyAlOZ35xoLVDm
         R61ZzHcKOAH1/n39wljQZh0t5jNcRo4QhhJhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/SBX7F0TUuVX6qnc8J+wosE+QUcqZiPheTHOsrFz+o=;
        b=T4Da1y1PtIZdcrtRHEBNj9zO1/8TE5NCG1cFoqoxnsmqUVj3nyraGE9lFM1wWZnYr5
         U3txGJzEgzEFpZzEpQ3cfE+iiPaoslGThAUqZcBBH/f6PVKxCRw7OqXszngKEgk4wDM1
         hV/nuzXqYQeHOl/1exPTuI95lwvVfPD2xI8jJbsTIoTAAouxpm9Q2xV9EjJP7m2h34Jw
         MTV94eA9eNUEhpGbvmdkvYWwnDMTubkSjRkmpLyRIOyL6Nkxl+KY5eEV7LScWFpj41Xr
         NjVQsLms630xI9RQJhAiiBcW4xb5V5w73Dc3oSKCxU3229jRxvKKk7R1jO9/4lbCE94o
         Covg==
X-Gm-Message-State: AOAM532i+7FytghWIxme+nwDoOQ1KCH1r5pplaE/uQaC2R9scVHdHflG
        3vYlg7rFDcgmAui0FtaHioaelXmb9LQ=
X-Google-Smtp-Source: ABdhPJzffQOvkng3FLr1U/vIAPs/sQQus9pvmZOpQ5aOmuthv0Po5gI8nURpCAv/vozO57yMefgmvg==
X-Received: by 2002:a17:906:6847:: with SMTP id a7mr61159629ejs.306.1594413281827;
        Fri, 10 Jul 2020 13:34:41 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id y22sm4243897ejf.108.2020.07.10.13.34.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 13:34:41 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a1so7395018ejg.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:34:40 -0700 (PDT)
X-Received: by 2002:a17:906:7005:: with SMTP id n5mr43500276ejj.130.1594413280262;
 Fri, 10 Jul 2020 13:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200710002209.6757-1-apronin@chromium.org> <1594408113.4494.16.camel@HansenPartnership.com>
In-Reply-To: <1594408113.4494.16.camel@HansenPartnership.com>
From:   Andrey Pronin <apronin@chromium.org>
Date:   Fri, 10 Jul 2020 13:34:28 -0700
X-Gmail-Original-Message-ID: <CAP7wa8+0Bkbm-QCW=xwJ7auZ18Bj1jJev9LcMxuA=i=6ZfT9yA@mail.gmail.com>
Message-ID: <CAP7wa8+0Bkbm-QCW=xwJ7auZ18Bj1jJev9LcMxuA=i=6ZfT9yA@mail.gmail.com>
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:08 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2020-07-09 at 17:22 -0700, Andrey Pronin wrote:
> > This patch prevents NULL dereferencing when using chip->ops while
> > sending TPM2_Shutdown command if both tpm_class_shutdown handler and
> > tpm_del_char_device are called during system shutdown.
> >
> > Both these handlers set chip->ops to NULL but don't check if it's
> > already NULL when they are called before using it.
> >
> > This issue was revealed in Chrome OS after a recent set of changes
> > to the unregister order for spi controllers, such as:
> >   b4c6230bb0ba spi: Fix controller unregister order
> >   f40913d2dca1 spi: pxa2xx: Fix controller unregister order
> > and similar for other controllers.
> >
> > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > ---
> >  drivers/char/tpm/tpm-chip.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-
> > chip.c
> > index 8c77e88012e9..a410ca40a3c5 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -296,7 +296,7 @@ static int tpm_class_shutdown(struct device *dev)
> >       struct tpm_chip *chip = container_of(dev, struct tpm_chip,
> > dev);
> >
> >       down_write(&chip->ops_sem);
> > -     if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +     if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
> >               if (!tpm_chip_start(chip)) {
> >                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
> >                       tpm_chip_stop(chip);
> > @@ -479,7 +479,7 @@ static void tpm_del_char_device(struct tpm_chip
> > *chip)
> >
> >       /* Make the driver uncallable. */
> >       down_write(&chip->ops_sem);
> > -     if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +     if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
> >               if (!tpm_chip_start(chip)) {
> >                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
> >                       tpm_chip_stop(chip);
>
> I really don't think this is the right fix.  The problem is that these
> two functions are trying to open code tpm_try_get_ops/tpm_put_ops (only
> really for the tpm2 shutdown) because they want to NULL out the ops
> before final mutex unlock.  The problem with the current open coding is
> it doesn't shut down the clock if required (not really a problem for
> shutdown, but might cause issues for simple rmmod).  I think this is
> because no-one noticed the open coding when get/put was updated.
>
> This code should all be abstracted into a single function and shared
> with tpm_try_get_ops/tpm_put_ops so we can't have this happen in
> future.  Possibly there should be a chip shutdown function which is
> only active for TPM2 which does the correct try_get/shutdown/put
> operation and then a separate simple get mutex, null ops, put mutex one
> that's guaranteed to be called last.

Yes, went for a minimal patch here to stop kernel panics, didn't try to
refactor. Note that we do hold chip->ops_sem in both cases, and it's a
write-lock, not a read-lock (as tpm_try_get_ops uses) since we are
changing chip->ops. Thanks to this write-lock there, shouldn't be parallel
operations that use chip->ops (so not locking chip->tpm_mutex shouldn't
affect it).

So, if I understand the idea right, can refactor to something like:
1) extract common code between tpm_del_char_device and
tpm_class_shutdown into a shared method;
2) further extract the part between up/down(chip->ops_sem) to be
re-used between tpm_try_get_ops/tpm_put_ops and this flow;
3) still have down_write/up_write in this flow vs
get/put_device + down_read/up_read in tpm_try_get_ops case.

Please let me know if that's a bad idea.

Will be unavailable next week, but will continue after that.

>
> James
>


-- 
Andrey
