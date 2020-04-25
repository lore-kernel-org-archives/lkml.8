Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D25DC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 21:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D8620714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 21:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGJnNK2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDYVAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 17:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgDYVAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 17:00:08 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D17FC09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 14:00:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id s63so14100175qke.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9HpfRS435lskObag0L5vmppJY/Hcu6mU2OIeCkAO2s=;
        b=uGJnNK2Q3UI/ALmhO3z/sKERhVcr2JjP/pvYj93M7Oatcw16z72Cs4hZrN8yIEnn0g
         ZQw0mg3yEenSzW8teRHySlW1M6GWAgQVgkp3jcit/PfQginacbw4jtpLfrxug40IAaCf
         O4fbaCJycmIsN2PGAJqnNFOPLHD4T0ZtXVzQ79w65jEoj+EGlcs5EaLUqUsy2QqIy6l3
         FwlqL0xq19ok78cMCKeaJayFoeVTVq5mqDFd6pTtL2+tAtDwXCa+1AxShU3ufQCSgguF
         2XzHkCRiD8w9ih4NB0PqYAuXxFeXvDAseM1vO+PJ1n1uoNRyB8mqU7QF2Edr6Q6PrU+L
         M3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9HpfRS435lskObag0L5vmppJY/Hcu6mU2OIeCkAO2s=;
        b=Axt/hjSAjBT/T1Zc9NP3fMB8Nu24wHbnrzdyfwEffEXcbsCjfqm5DQLP21eN7wW1ty
         bKY7lOwGztFgKwPxYFlERptEpAOuhcXz50TnHdNeUlMittGuQTIN2nCh0Fc/jvve8zS3
         5x9uPqYLp2Dnp76VRAazhNqjvVp8gr5qn6EEVikNBhiwJIMAMVkDBNktDMnGZGN+gICr
         B6Dbqt3sd3YXcf3t8TY11JSySJvhgeAWmravKYn3R4rl83fDg1sorSXYAAzqBICIYEPw
         GT4b+WFUDwW+NLIbdy5e5aCUbgEtyij6dYoJ3t1KSBh/rFnD/YpMJdP6ic1LX2gl6IRS
         ILqA==
X-Gm-Message-State: AGi0Pub3eKVaKkheikGbQUvlCs/MOGOv/LRfYwHEKgAu7ht+eBYdQ7OU
        InbbbNYf5d+SwNlnDk74Wrb9Ax5aDsMOIooK9aoYcw==
X-Google-Smtp-Source: APiQypJSG8qRMVDTL3lZPahRciqbrOa64EU6noSCspFMvHTrWIJ8WSho1sVTd+flr2CVFQOOf7t5j2xcLdQnv9OvTjA=
X-Received: by 2002:a37:6691:: with SMTP id a139mr15665894qkc.501.1587848407222;
 Sat, 25 Apr 2020 14:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200424025057.118641-1-khazhy@google.com> <20200424190039.192373-1-khazhy@google.com>
 <66f26e74-6c7b-28c2-8b3f-faf8ea5229d4@akamai.com>
In-Reply-To: <66f26e74-6c7b-28c2-8b3f-faf8ea5229d4@akamai.com>
From:   Khazhismel Kumykov <khazhy@google.com>
Date:   Sat, 25 Apr 2020 13:59:56 -0700
Message-ID: <CACGdZYLD9ZqJNVktHUVe6N4t28VKy-Z76ZcCdsAOJHZRXaYGSA@mail.gmail.com>
Subject: Re: [PATCH v2] eventpoll: fix missing wakeup for ovflist in ep_poll_callback
To:     Jason Baron <jbaron@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Roman Penyaev <rpenyaev@suse.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Heiher <r@hev.cc>,
        stable@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004fb90705a423c480"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004fb90705a423c480
Content-Type: text/plain; charset="UTF-8"

On Sat, Apr 25, 2020 at 9:17 AM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 4/24/20 3:00 PM, Khazhismel Kumykov wrote:
> > In the event that we add to ovflist, before 339ddb53d373 we would be
> > woken up by ep_scan_ready_list, and did no wakeup in ep_poll_callback.
> > With that wakeup removed, if we add to ovflist here, we may never wake
> > up. Rather than adding back the ep_scan_ready_list wakeup - which was
> > resulting in unnecessary wakeups, trigger a wake-up in ep_poll_callback.
>
> I'm just curious which 'wakeup' we are talking about here? There is:
> wake_up(&ep->wq) for the 'ep' and then there is the nested one via:
> ep_poll_safewake(ep, epi). It seems to me that its only about the later
> one being missing not both? Is your workload using nested epoll?
>
> If so, it might make sense to just do the later, since the point of
> the original patch was to minimize unnecessary wakeups.

The missing wake-ups were when we added to ovflist instead of rdllist.
Both are "the ready list" together - so I'd think we'd want the same
wakeups regardless of which specific list we added to.
ep_poll_callback isn't nested specific?

>
> Thanks,
>
> -Jason
>
> >
> > We noticed that one of our workloads was missing wakeups starting with
> > 339ddb53d373 and upon manual inspection, this wakeup seemed missing to
> > me. With this patch added, we no longer see missing wakeups. I haven't
> > yet tried to make a small reproducer, but the existing kselftests in
> > filesystem/epoll passed for me with this patch.
> >
> > Fixes: 339ddb53d373 ("fs/epoll: remove unnecessary wakeups of nested epoll")
> >
> > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> > Reviewed-by: Roman Penyaev <rpenyaev@suse.de>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Heiher <r@hev.cc>
> > Cc: Jason Baron <jbaron@akamai.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> > v2: use if/elif instead of goto + cleanup suggested by Roman
> >  fs/eventpoll.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 8c596641a72b..d6ba0e52439b 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -1171,6 +1171,10 @@ static inline bool chain_epi_lockless(struct epitem *epi)
> >  {
> >       struct eventpoll *ep = epi->ep;
> >
> > +     /* Fast preliminary check */
> > +     if (epi->next != EP_UNACTIVE_PTR)
> > +             return false;
> > +
> >       /* Check that the same epi has not been just chained from another CPU */
> >       if (cmpxchg(&epi->next, EP_UNACTIVE_PTR, NULL) != EP_UNACTIVE_PTR)
> >               return false;
> > @@ -1237,16 +1241,12 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
> >        * chained in ep->ovflist and requeued later on.
> >        */
> >       if (READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR) {
> > -             if (epi->next == EP_UNACTIVE_PTR &&
> > -                 chain_epi_lockless(epi))
> > +             if (chain_epi_lockless(epi))
> > +                     ep_pm_stay_awake_rcu(epi);
> > +     } else if (!ep_is_linked(epi)) {
> > +             /* In the usual case, add event to ready list. */
> > +             if (list_add_tail_lockless(&epi->rdllink, &ep->rdllist))
> >                       ep_pm_stay_awake_rcu(epi);
> > -             goto out_unlock;
> > -     }
> > -
> > -     /* If this file is already in the ready list we exit soon */
> > -     if (!ep_is_linked(epi) &&
> > -         list_add_tail_lockless(&epi->rdllink, &ep->rdllist)) {
> > -             ep_pm_stay_awake_rcu(epi);
> >       }
> >
> >       /*
> >

--0000000000004fb90705a423c480
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPBgYJKoZIhvcNAQcCoIIO9zCCDvMCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxpMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
BQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wUQYIKwYBBQUHAQEE
RTBDMEEGCCsGAQUFBzAChjVodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3Nt
aW1lY2EyMDE4LmNydDAfBgNVHSMEGDAWgBRMtwWJ1lPNI0Ci6A94GuRtXEzs0jA/BgNVHR8EODA2
MDSgMqAwhi5odHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dzc21pbWVjYTIwMTguY3JsMA0G
CSqGSIb3DQEBCwUAA4IBAQCM37MMrUvgKBlbkfClP3kSaljmhqmtbhA855Dxg0ExJEaXMLDnSEod
BZm4+79Rcp/gCP67jOVlkJHRSTPco73qpOMg8Q9aXMbcysY/rm3bul1wpALN1dQh8STLYiDdNBXJ
LJZxf7nC3+xcLEb0+RTU05lUVCzmixKU665YZspUCQttLL7LxY8k7vpLtXeX7+OP6mxVsEOca9CI
fEybv+pk4+vHfIg3XiUK2Qs4qTHSFZ09OuPSRqkO1CY/AET8DPwXkO2ByN/gdUYo1po23haQT7kB
qhSVsP/BmQ7F6qER6f8mDR3F0uH26W4ZFxa/htst/Pb0qoQnkyDXLPSLJa9UMYICYTCCAl0CAQEw
XzBLMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEhMB8GA1UEAxMYR2xv
YmFsU2lnbiBTTUlNRSBDQSAyMDE4AhABiQs/r7YF6iuE/NQrZF28MA0GCWCGSAFlAwQCAQUAoIHU
MC8GCSqGSIb3DQEJBDEiBCBijOP7/Lrw99OvIfxrcb8JlDfa0z2/+UFYeEOnhYH1DDAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA0MjUyMTAwMDdaMGkGCSqGSIb3
DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcN
AwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAE
ggEAJHHip4d2k/XJ+IR79dCnnEY7HJGggM7PqgoPTXuyWF71tPpLvaIq5etVP3ASLzAnbm5uXaGO
tVKXeFZ/knDzGSwZP1ZmfeyAjmH73+/mrAsyrHr0o8LMZJoj0CpU3iR+lmSTCNDIsnKe+LPR2WQu
8RooFmdGEDN5RpOsJ34LLPKFZm/tQ1M+b4Uxgqk0VqVVTVBq0T/I0sKeE0xAchKUZN8rtElc8HbP
jbNo25FB0aLD4eEjhXUUv9tKY4zpT8op7pTfsRJMdH3CDLE5zoD4pPIhCfk0HNNboOP8lCVBs4Ts
9YmJobgOeNCaGt5qe/L6jMjEk1BygutcY6LSSw0bIQ==
--0000000000004fb90705a423c480--
