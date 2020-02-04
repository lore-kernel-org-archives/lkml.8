Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12713C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31E62166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qYYs4TVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgBDHcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:32:05 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46750 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgBDHcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:32:04 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200204073203euoutp02eab7e347ca7de8fa8608d689575e1bb7~wIpwdwh_20073800738euoutp02J
        for <linux-kernel@vger.kernel.org>; Tue,  4 Feb 2020 07:32:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200204073203euoutp02eab7e347ca7de8fa8608d689575e1bb7~wIpwdwh_20073800738euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580801523;
        bh=bc89vh6v/2gyMbPBdgQPiR0QMlp+/pxJ93nah1o2SvU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qYYs4TVjHfDwTeF9EJYxsqSnObDMf5yzX9HaISsLCKOuhsT0zUR2olQbn5e8MTm64
         JbPsHVPAybfa+z+XohZrKeWWTjvWhCUe77Cqxo4cmf6LyJ5EUVRLQwgo1lsVRASi7n
         pZfGUl/NA1/jqrfz2cQlJd7aVHUZlZ4lyQp8Gnpo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200204073202eucas1p2c327e30f68a2dc92a5863c688cfe1799~wIpwPBAlF3126831268eucas1p2J;
        Tue,  4 Feb 2020 07:32:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5A.C8.60698.2FD193E5; Tue,  4
        Feb 2020 07:32:02 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200204073202eucas1p217d2eb45ea16e6d854e1ad4639ca0447~wIpv3yLvz2806028060eucas1p2X;
        Tue,  4 Feb 2020 07:32:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200204073202eusmtrp10b4b559b7a9c768fcd06bafda7668fed~wIpv3Hh811155711557eusmtrp1S;
        Tue,  4 Feb 2020 07:32:02 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-53-5e391df2a6c6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F0.55.07950.2FD193E5; Tue,  4
        Feb 2020 07:32:02 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200204073201eusmtip2bb0c0e02f8c0d67ba410c50b522710d7~wIpvXX09E0785207852eusmtip2M;
        Tue,  4 Feb 2020 07:32:01 +0000 (GMT)
Subject: Re: [PATCH v5] platform: cros_ec: Query EC protocol version if EC
 transitions between RO/RW
To:     Yicheng Li <yichengli@google.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Yicheng Li <yichengli@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <504e98c1-224e-8311-cef1-328d62393643@samsung.com>
Date:   Tue, 4 Feb 2020 08:32:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAB8_tbG-9ntKe3NoMfiDEZsYqbM4U5mK24JNHeikzxG9bkuvGg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87qfZC3jDP7N0LOY/uQyi8WF3yvZ
        LGYvPspicXnXHDaLGef3MVl8bv3HZjH3+B12i9WPL7I5cHjMbrjI4rFz1l12jwWbSj0+b5IL
        YInisklJzcksSy3St0vgynja1M5eMIG/YuZywQbGf9xdjJwcEgImEo92d7N3MXJxCAmsYJRY
        +nUqI4TzhVGi4XQ3M4TzmVHi88I5rDAt7y49hapazijx4NIOFgjnLaPErT9zWECqhAXSJP4t
        +80MYosIqEp0L73OBlLELLCYSeL83T+MIAk2AUOJrrddbCA2r4CdxNWGN2A2i4CKxJKW+ewg
        tqhArMSZY99ZIWoEJU7OfAK2gFMgUOLJOohlzALyEs1bZzND2OISt57MZwJZJiGwiV1i4otj
        jBB3u0isePcQ6gdhiVfHt7BD2DISpyf3sEA0NDNKPDy3lh3C6WGUuNw0A6rbWuLOuV9A53EA
        rdCUWL9LHyLsKLHlznsWkLCEAJ/EjbeCEEfwSUzaNp0ZIswr0dEmBFGtJjHr+Dq4tQcvXGKe
        wKg0C8lrs5C8MwvJO7MQ9i5gZFnFKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmIRO/zv+
        dQfjvj9JhxgFOBiVeHg1HC3ihFgTy4orcw8xSnAwK4nw1lmZxgnxpiRWVqUW5ccXleakFh9i
        lOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAOOnU/9nLPA5xaJ5JCeFfeMX29w3vqjJn
        1lSDwx/+t9zYmHGH2db1Vj777rfup75/NQ8pWLgz8/NXft8k0SCfF1nR8U8VHqnuWBIkEmBd
        nN9kGjxDdumfyYf8nH66HHmmersgw1Bn0i628ExPJbd79UW5N+evLQtwDdrecCvkTGZa+e3U
        paXmSizFGYmGWsxFxYkAKkQHLD4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7qfZC3jDOZsELeY/uQyi8WF3yvZ
        LGYvPspicXnXHDaLGef3MVl8bv3HZjH3+B12i9WPL7I5cHjMbrjI4rFz1l12jwWbSj0+b5IL
        YInSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy3ja
        1M5eMIG/YuZywQbGf9xdjJwcEgImEu8uPWXsYuTiEBJYyihxu+cLO0RCRuLktAZWCFtY4s+1
        LjaIoteMEneu32MDSQgLpEn8W/abGcQWEVCV6F56HayIWWApk8SfNVfBioQEWpklrvREgths
        AoYSXW+7wOK8AnYSVxvegNksAioSS1rmg20WFYiVOLa9jR2iRlDi5MwnLCA2p0CgxJN1c8Bs
        ZgEziXmbHzJD2PISzVtnQ9niEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGR
        XnFibnFpXrpecn7uJkZgzG079nPLDsaud8GHGAU4GJV4eDUcLeKEWBPLiitzDzFKcDArifDW
        WZnGCfGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MB3klcQbmhqaW1gamhubG5tZKInzdggc
        jBESSE8sSc1OTS1ILYLpY+LglGpgZGdqe7zmzGcn/TUhQccOTU40TRY84iu9c8WUha+Uy/Kk
        tiw6uGR+wdmt2xekJa/ft1r++c2M91e4nlrP/Kri+u3lEyudA16spz9vqTvmyLjZw6s75NWy
        3HZn02lTWn7vs5Ga2a5y7P+366un/WlJui+45aTs00UX1PWDXX44pxTG3Q4M7Zi184kSS3FG
        oqEWc1FxIgC9iJaDzwIAAA==
X-CMS-MailID: 20200204073202eucas1p217d2eb45ea16e6d854e1ad4639ca0447
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200131073925eucas1p25bde5452aaa821435367dbfa9904a476
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200131073925eucas1p25bde5452aaa821435367dbfa9904a476
References: <CGME20200131073925eucas1p25bde5452aaa821435367dbfa9904a476@eucas1p2.samsung.com>
        <20200107220640.834-1-yichengli@chromium.org>
        <5bbca1db-d99b-9adc-b623-8f5ae1b1bb86@samsung.com>
        <CAFqH_5307FZ2njAhAUJ011usvfiuBZ9cd10yNRLVPuMZNHWD4w@mail.gmail.com>
        <093ac3c3-204f-3f85-af0f-ac5b17512708@samsung.com>
        <CAB8_tbG-9ntKe3NoMfiDEZsYqbM4U5mK24JNHeikzxG9bkuvGg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 04.02.2020 00:00, Yicheng Li wrote:
> Hi Enric and Marek,
>
> Those Samsung Chromebooks (Snow, Peach-Pit and Peach-Pi) do not 
> support mkbp events, thus we should not do this "ready event handling" 
> for them.
> Below is my fix, I also sent the entire thing as a v6 in a separate 
> email. Thanks!
>
> diff --git a/drivers/platform/chrome/cros_ec.c 
> b/drivers/platform/chrome/cros_ec.c
> index 38ec1fb409a5..f16804db805b 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -218,12 +218,17 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>                 dev_dbg(ec_dev->dev, "Error %d clearing sleep event to 
> ec",
>                         err);
>
> -       /* Register the notifier for EC_HOST_EVENT_INTERFACE_READY 
> event. */
> -       ec_dev->notifier_ready.notifier_call = cros_ec_ready_event;
> -       err = blocking_notifier_chain_register(&ec_dev->event_notifier,
> -  &ec_dev->notifier_ready);
> -       if (err)
> -               return err;
> +       if (ec_dev->mkbp_event_supported) {
> +               /*
> +                * Register the notifier for EC_HOST_EVENT_INTERFACE_READY
> +                * event.
> +                */
> +               ec_dev->notifier_ready.notifier_call = 
> cros_ec_ready_event;
> +               err = blocking_notifier_chain_register(
> +                       &ec_dev->event_notifier, &ec_dev->notifier_ready);
> +               if (err)
> +                       return err;
> +       }
>
>         dev_info(dev, "Chrome EC device registered\n");
>
I confirm that this patch fixes the issue on Samsung Exynos-based 
Chromebooks (Snow, Peach-Pit and Peach-Pi).

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

