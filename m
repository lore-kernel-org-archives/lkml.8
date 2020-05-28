Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356C4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08098207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pVhJ0Qiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391202AbgE1Op0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:45:26 -0400
Received: from mout.web.de ([212.227.17.12]:60099 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgE1OpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590677106;
        bh=Ji+TnI2/l/tfPAhTFGuY2bDQt0RWf1M1u3vwa2F6Hss=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pVhJ0QiyzrelEonbutiGe/B4RvYYC5lOTafZl0dgU/mK9PBqWKiW5PEcjs4iaEVWs
         iLnVdOoAjgZEAF2ku8Tc8JMdRVuQBqd90X4J/6vOLy3/lL4jtYmCSuPLYLsThxFJ0R
         zq/hyJuZgRFc5kkajyywUtbSeuGFPDrujsocoMlk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.30.242]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBB3s-1jjHqu0IWc-00CkOR; Thu, 28
 May 2020 16:45:06 +0200
Subject: Re: [v5] workqueue: Remove unnecessary kfree() call in rcu_free_wq()
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Zhang Qiang <qiang.zhang@windriver.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200527075715.36849-1-qiang.zhang@windriver.com>
 <284c7851-4e89-a00f-a2e6-aa8e2e1f3fce@web.de>
 <DM6PR11MB32573F3884A864ECD586235EFF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <DM6PR11MB3257D6E7E93A518392502809FF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <20200528095703.GH30374@kadam>
 <CAJhGHyD1nV=M=ccycqCMt86GMuZGkO9trbJ=4ti4EzP9kta6iA@mail.gmail.com>
 <20200528122545.GP22511@kadam>
 <CAJhGHyBUkMZ=cV+Qf-5+PMAFqgebbRLc46OZSSUSgoRROpUk2A@mail.gmail.com>
 <20200528140357.GL83516@mtj.thefacebook.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a3349efe-5291-637a-f98d-407a33f2fede@web.de>
Date:   Thu, 28 May 2020 16:45:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528140357.GL83516@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:SEPL94SsTVWqsHP+v75Rc9Xv5QXiVgVLCbgV//JUdIwaxlNCPaM
 FryG8tBcnSJ2nKvUJ0Q298R4uiDRj2GpN2JuYJK5fnJmCT0SJRjRDrZ5PoId/Vb5VR/p/ul
 SBeMHiMgviud4J7GPdlwtFFu7fhy1grsOET32MjdqYbiRYVyYOAsZwMKnyes/51T1ZH8NTz
 Sh80XKB2o1z2opRKBYfXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:axBDLpeRwhk=:DTDhoN+CvquUprReTOYZO3
 691D2ldjxpZfqaUfktWxUpIgu5qeeIb6btsUf/12bQIUCvHumYVQ0LrzAoSQuJ2hQlODdWzdT
 XWryfgpiE7KqhFd88knIQgnaAoDE6bM3PYsUEKgM5PmhLhy1tuVKqYXfZ2+KyV/2cKljkQ5FG
 +xqpePzcb9nAU+JE44wEnmM1qLgGy2XozW+b+a1NMNNKB/F1G8bE8Vg0aKkh7oxkeMAMRVlc8
 WxK3j6ciXy+qrARWQc655TBk+ZWf6kjItA0sJ83rbKt93WHX9tR35uaU1WXH0ApI7WoEyEB2E
 /2pnB2v+iATuwUUl2YVL16jmuumqkD4PRXrJQm33KmESV0ezRRXh4mbqhBLya3EjKnD8HZH8K
 ucqoR6LZUe4ABWregE/zD1Q8Z3IiStptujhXcLYi9Tffb2wTmf0e5iU02ETttV8IrOyHVyAbg
 +tktd9f2XHgnl2Hs+1IULUprxTxg/dli/BM3ChBxcBbUYt1Ysdol8hEmjMhqqetJxWVFhiSdJ
 F37FXatP3gKnlaBLAQbptt2ataiM/XpopwLkUWUfAJgFiNTjeLVZCO6dXF+u3sxfwaKmPV04q
 evHDlWhZpALSXBu54NeZEdX0EIJc/a/Iv28VSQHILxz383LZGP5q+IKFGLzqAviTWHsVNeAMG
 C9NJJD7HO2f0tVbkqWS25tNPrAewj5KVt0OAVtyi0mG5w/kcFYZLMeS1nlZQi9cd4FELOrE9c
 HGZ+pNrIKNmsJn9g4dJ5SgUzJ+OM3BJpu4DYZuQHIExRADheeVuMK3NiErumYx0le+1y7GuGD
 ADkx01AtNoogdWfd8Rh+PKaCWfDbCzITr0jde+Yihm8e6nJtlW2KkkkFcjeA3Nkyb9rDeClAx
 jkUAvXO0h90buw9ovIUEd7i4mXokefHAaF8fh3ctit2SUlgrNfcJN/Zo8d9bBHoz+TNpEiX9p
 tlVRZ6dOIyq+1XcVPuEX3NbS+qZ7VyN52rLrkilUhQkXnbAU+ioCw6+LYjayCD8RlPmW3ViT8
 OWrREZT1MwAorvgRMo2HtYtzQmeZT730nDe3ES0JSsKF7zEnljWtF496l7yJtpwEczByUl5Un
 YytbiZpE2tH0gSZItJ4zBBpDgrGA0U7RHHSBIt9AK5VZEAlHO+1RQuuur++9qlcXzhqPf2yjY
 4bIdnkG9Qkk8qbovC8wCdi1Ooe7cGs6EdGHU1mxRuJRtJZtxkk8FwIQaIt3h9yfZTLudGwMe0
 I6NwrcgRUHKa6xr+U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, regardless of who puts a wq the last time, the base reference is put
> by destroy_workqueue() and thus it's guaranteed that a wq can't be rcu freed
> without going through destroy_workqueue(). lol I'm undoing the revert.

* Would you like to add such background information to the change description?

* How do you think about integrate a following patch version after
  the extra clarification?

Regards,
Markus
