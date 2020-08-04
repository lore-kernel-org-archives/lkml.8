Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2711C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAFD207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIe1a+u6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgHDEXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHDEXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:23:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF829C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 21:23:04 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q128so4953046qkd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 21:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQichsvBy+MsltI6WkAz/Wx6SRnn66f1UEHlGv+xZsM=;
        b=RIe1a+u60Aa8tEz9Q8BsfD2j9Ku9gGz+zWLyvdOdi3enfec/WwvGVgTlr/btqk2aVa
         4MCbROcl0O9lS4lXsiiOZtHvlEg7gJgB3uycJAgxIUxSlSLdUqOtpb4GBDZeI5hNwXX3
         BCw5jG5y2yLgjwshwLlZ2FC4FvQ0dVoWotiEs1o9pr/o8XaRpReK0VRr6DILqIDOfBPD
         WOTysAlPbVL8WGIBiq33a+B+YI3WMHgNVvwwjzAA8gx5rLylOnoaGwHMeSnLTkUd2lcc
         xercUxUDqaHfhM2ymUq55Gi5EIkImMGWZSogRgRrSnu1nzZ7oQFVmBJyOoAZeq6FQIe6
         Hklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQichsvBy+MsltI6WkAz/Wx6SRnn66f1UEHlGv+xZsM=;
        b=PrOoQZucgzp/NFAkuMhlZHCy4R4e2CfLbi4bXsmFqdEB8UWmnpd4n9NFqHb+AiMzdL
         sno+e7MuEurXVKV0SPjmJcGOAAb9EBmA9udLnp1dqDV5yk7qwbA8HgYNsqZxZkUkk5uw
         hceZzde3LUh8H61+QvSNoS0By7Qde+mzLs0b/UpVV8PIEm6wxHzpCYSDH2mZ/NZkE7Mh
         5G3H+gaCQIK5HelKUp74y3tyQ8/f/2nxuyzXZG1FU/xRd6J63E4SfXrOeivoscmW2cIG
         gg9/EQYBWq09S5/HmNXkW52hARyA6kCm7PL0bWOvg96HEn7bCo8AbePWAZcQL1xPsvih
         s0YA==
X-Gm-Message-State: AOAM5327Py5qWb7WyiILNw4meW+vc8Hqs5XGGLTnJe4inK0rQ2Fu/e9U
        fQj7tXR+ClUOcqqsq99zS9G1MlFWbjrG4V00kms=
X-Google-Smtp-Source: ABdhPJwuZnXyfPk+0sVbOn12nxRzjLREQ1LreTAdQrhYhhkygRuHaxRvUU68poaYY+kI6IVAJLkhARLnc9K+/SpWayM=
X-Received: by 2002:a05:620a:628:: with SMTP id 8mr20334448qkv.103.1596514984138;
 Mon, 03 Aug 2020 21:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
 <20200803054037.GA1056@Asurada-Nvidia> <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
 <20200803215735.GA5461@Asurada-Nvidia> <CAA+D8ANQxnvR2bOyHVRs5h2NJhMeVh4gjLPknaz7aQ86MtL0sQ@mail.gmail.com>
 <20200804021114.GA15390@Asurada-Nvidia> <CAA+D8ANagfMXPAkK4-vBDY9rZMukVUXs8FfBCHS0avXt57pekA@mail.gmail.com>
 <20200804030004.GA27028@Asurada-Nvidia> <CAA+D8ANuLQuUO+VsABjt2t1ccK+LGayq13d6EEcV18=4KNaC+w@mail.gmail.com>
In-Reply-To: <CAA+D8ANuLQuUO+VsABjt2t1ccK+LGayq13d6EEcV18=4KNaC+w@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 4 Aug 2020 12:22:53 +0800
Message-ID: <CAA+D8AP=27SdR68T-LiQHkJ0_dJaqtgcS-oi9d8arUzvTz5GwA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Clean code for synchronize mode
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 11:23 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
>
> On Tue, Aug 4, 2020 at 11:00 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Tue, Aug 04, 2020 at 10:35:12AM +0800, Shengjiu Wang wrote:
> > > On Tue, Aug 4, 2020 at 10:11 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > > >
> > > > On Tue, Aug 04, 2020 at 09:39:44AM +0800, Shengjiu Wang wrote:
> > > > > On Tue, Aug 4, 2020 at 5:57 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 03, 2020 at 04:04:23PM +0800, Shengjiu Wang wrote:
> > > > > >
> > > > > > > > > clock generation. The TCSR.TE is no need to enabled when only RX
> > > > > > > > > is enabled.
> > > > > > > >
> > > > > > > > You are correct if there's only RX running without TX joining.
> > > > > > > > However, that's something we can't guarantee. Then we'd enable
> > > > > > > > TE after RE is enabled, which is against what RM recommends:
> > > > > > > >
> > > > > > > > # From 54.3.3.1 Synchronous mode in IMX6SXRM
> > > > > > > > # If the receiver bit clock and frame sync are to be used by
> > > > > > > > # both the transmitter and receiver, it is recommended that
> > > > > > > > # the receiver is the last enabled and the first disabled.
> > > > > > > >
> > > > > > > > I remember I did this "ugly" design by strictly following what
> > > > > > > > RM says. If hardware team has updated the RM or removed this
> > > > > > > > limitation, please quote in the commit logs.
> > > > > > >
> > > > > > > There is no change in RM and same recommandation.
> > > > > > >
> > > > > > > My change does not violate the RM. The direction which generates
> > > > > > > the clock is still last enabled.
> > > > > >
> > > > > > Using Tx syncing with Rx clock for example,
> > > > > > T1: arecord (non-stop) => set RE
> > > > > > T2: aplay => set TE then RE (but RE is already set at T1)
> > > > > >
> > > > > > Anything that I am missing?
> > > > >
> > > > > This is a good example.
> > > > > We have used this change locally for a long time, so I think it is
> > > > > safe to do this change, a little different with the recommandation.
> > > >
> > > > Any reason for we have to go against the recommendation?
> > >
> > > Previous code will enable TE and RE  together even for asynchronous
> > > mode.
> > > And for recommendation, previous code just consider the RX sync with
> > > TX, but still violates the recommendation for TX sync with RX case.
> > > So at least this new change is some kind of improvement.
> >
> > Okay. Let's change it then. Please make sure to update/remove
> > those old comments in the trigger(). And it's probably better
> > to mention that what we do now is a bit different from RM:
> >         /*
> >          * Enable the opposite direction for synchronous mode
> >          * 1. Tx sync with Rx: only set RE for Rx; set TE & RE for Tx
> >          * 2. Rx sync with Tx: only set TE for Tx; set RE & TE for Rx
> >          *
> >          * RM recommends to enable RE after TE for case 1 and to enable
> >          * TE after RE for case 2, but we here may not always guarantee
> >          * that happens: "arecord 1.wav; aplay 2.wav" in case 1 enables
> >          * TE after RE, which is against what RM recommends but should
> >          * be safe to do, judging by years of testing results.
> >          */
>
> Thank you for the agreement.
>
> >
> > Btw, do we need similar change for TRIGGER_STOP?
>
> This is a good question. It is better to do change for STOP,
> but I am afraid that there is no much test to guarantee the result.
>
> best regards
> wang shengjiu

Maybe we can do this change for STOP.

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 1c0e06bb3783..6e4be398eaee 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -517,6 +517,37 @@ static int fsl_sai_hw_free(struct
snd_pcm_substream *substream,
        return 0;
 }

+static void fsl_sai_config_disable(struct fsl_sai *sai, bool tx)
+{
+       unsigned int ofs = sai->soc_data->reg_offset;
+       u32 xcsr, count = 100;
+
+       regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
+                          FSL_SAI_CSR_TERE, 0);
+
+       /* TERE will remain set till the end of current frame */
+       do {
+               udelay(10);
+               regmap_read(sai->regmap, FSL_SAI_xCSR(tx, ofs), &xcsr);
+       } while (--count && xcsr & FSL_SAI_CSR_TERE);
+
+       regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
+                          FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
+
+       /*
+        * For sai master mode, after several open/close sai,
+        * there will be no frame clock, and can't recover
+        * anymore. Add software reset to fix this issue.
+        * This is a hardware bug, and will be fix in the
+        * next sai version.
+        */
+       if (!sai->is_slave_mode) {
+               /* Software Reset for both Tx and Rx */
+               regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs),
FSL_SAI_CSR_SR);
+               /* Clear SR bit to finish the reset */
+               regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), 0);
+       }
+}
 static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
                struct snd_soc_dai *cpu_dai)
@@ -525,7 +556,7 @@ static int fsl_sai_trigger(struct
snd_pcm_substream *substream, int cmd,
        unsigned int ofs = sai->soc_data->reg_offset;

        bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-       u32 xcsr, count = 100;
+       u32 xcsr;

        /*
         * Asynchronous mode: Clear SYNC for both Tx and Rx.
@@ -579,43 +610,12 @@ static int fsl_sai_trigger(struct
snd_pcm_substream *substream, int cmd,

                /* Check if the opposite FRDE is also disabled */
                regmap_read(sai->regmap, FSL_SAI_xCSR(!tx, ofs), &xcsr);
-               if (!(xcsr & FSL_SAI_CSR_FRDE)) {
-                       /* Disable both directions and reset their FIFOs */
-                       regmap_update_bits(sai->regmap, FSL_SAI_TCSR(ofs),
-                                          FSL_SAI_CSR_TERE, 0);
-                       regmap_update_bits(sai->regmap, FSL_SAI_RCSR(ofs),
-                                          FSL_SAI_CSR_TERE, 0);
-
-                       /* TERE will remain set till the end of current frame */
-                       do {
-                               udelay(10);
-                               regmap_read(sai->regmap,
-                                           FSL_SAI_xCSR(tx, ofs), &xcsr);
-                       } while (--count && xcsr & FSL_SAI_CSR_TERE);
-
-                       regmap_update_bits(sai->regmap, FSL_SAI_TCSR(ofs),
-                                          FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
-                       regmap_update_bits(sai->regmap, FSL_SAI_RCSR(ofs),
-                                          FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
-
-                       /*
-                        * For sai master mode, after several open/close sai,
-                        * there will be no frame clock, and can't recover
-                        * anymore. Add software reset to fix this issue.
-                        * This is a hardware bug, and will be fix in the
-                        * next sai version.
-                        */
-                       if (!sai->is_slave_mode) {
-                               /* Software Reset for both Tx and Rx */
-                               regmap_write(sai->regmap, FSL_SAI_TCSR(ofs),
-                                            FSL_SAI_CSR_SR);
-                               regmap_write(sai->regmap, FSL_SAI_RCSR(ofs),
-                                            FSL_SAI_CSR_SR);
-                               /* Clear SR bit to finish the reset */
-                               regmap_write(sai->regmap, FSL_SAI_TCSR(ofs), 0);
-                               regmap_write(sai->regmap, FSL_SAI_RCSR(ofs), 0);
-                       }
-               }
+               if (sai->synchronous[tx] && !sai->synchronous[!tx] &&
!(xcsr & FSL_SAI_CSR_FRDE))
+                       fsl_sai_config_disable(sai, !tx);
+
+               if (sai->synchronous[tx] || !sai->synchronous[!tx] ||
!(xcsr & FSL_SAI_CSR_FRDE))
+                       fsl_sai_config_disable(sai, tx);
+
