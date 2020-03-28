Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F15C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 07:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459B420714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 07:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qPhWrXhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgC1Hhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 03:37:33 -0400
Received: from mout.web.de ([212.227.17.12]:41285 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgC1Hhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 03:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585381019;
        bh=EDEH9jdg6/zn01RnRrpu4yO6+wEMUBtPpvCZL68yIjU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qPhWrXhV7m2phxYTMsH4vVcOkgDmUR/RRnP7X4c+ulCaEC+3st49rlGzPcF9hJZqo
         4DzN/zPXglXOztmCTA0yfpQfnZdnPcK6SC6aSRFkujgvx/DLQtmy+0pfarY9tLH2Md
         +O3qGu0p1oN0EFoPdnxvncS19FsTjtO2jhiLVHi4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.150.134]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ltnmz-1jPpJm0GqD-011E4U; Sat, 28
 Mar 2020 08:36:59 +0100
Subject: Re: [PATCH v3 05/10] mmap locking API: convert mmap_sem call sites
 missed by coccinelle
To:     Michel Lespinasse <walken@google.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-6-walken@google.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
Date:   Sat, 28 Mar 2020 08:36:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327225102.25061-6-walken@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:WfN6iMoyPNkwiSWKgKgM43tFwkiSrc4OThnzDZe1Vx7oRdJ6kiN
 n4orh7sp5gV+dYEYQvjXkGcGn6Yq2K0xcb67dKR6Ni5TNCdLPG3wxoTVkTC8bWwkm2QamJS
 KiJkTIk3uIWslzHhGBCt5DtJvnCEiC4TV0E7jfBurTjPw2D6M9yAN7RPf8Pe7bSGvt8yLui
 DKXvG5D0Pp2OG01fxsfqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h9r6F5gZxUE=:eMgL21AmjASjtJzVRR8GOr
 QX0F7pxrb1WzX5vxgKyt4bb1XNYQmDgPkDJbEUYsUd/siQoPCYDcqqZ9jfdxRhFM6jpXqjpLJ
 O8O7b196Z/o8jOyoZJ5ocGDAdQ3Q0XCVxVE+9FEx4DBT4cvzmYIZakx3ox6GS78+Sdg3R7LV4
 Mku0qc06LgQdpCyBaq5hCxfOZjku5SKXtPx4FrKiMJZ7Tbpn2cnySiHjEi1JxFuzALpet9p/y
 MNTYy9aycGC7MOktFCcJ0fwyGTjBkprr2RcdWsO4kavqMkZnnjGv2Yo5RwTqH2uNjdCZrsj5F
 kIU7y0dfQqiaYxR/+aaXNIKDG0Dc1KFBUI0JQCH9V5xs+7CrIIy0a2lOSYtdYkAlxtL9i9cS9
 MLWHTu6MgfKor2lHFxts7XQpOe5lohbaqS9/833tm1n92QcrlCAZ7oS1LCqkLVi/7pB+E8q60
 Rz0zTC8eEu5rmrcsDov4NCJ3GdYbagUBTVHaTl28SMYwlpcW65ePOJsK9nUG8+yUvepGsv/Mx
 C3f2O1a9nxLLrJd7fgCex5kXL/l6KVkNWzGvtBNc0coVXxjrptVmTH7JFdEOE2QAXoc1ZcYnY
 Qut5WoHGyAYglFaBGY4Sx/ANjWSyJkiDssUOytwWTVD9VpO0J5yBN1u4gcFpQ2YDVV+dVv3hK
 e6wMnZY2y6wYscGOdit5q5LW5BuMOzRU802ND6QTCDMs1Qgu4pDxjFKcyUFDa6s5eeCFO5qAh
 Y1kBqEYXJ1c7zNv5xoyvkzzNfpVORJU4T5HJozzFwVBWpz4ECjXy+bno5fxO196aFJuOndVcf
 Et+r0qnPSK/3QQHZJS2N71hv7L2K203hnn56munzPRd5u0mk6w6SiGhpzqV1H3VkP2p/4/5V0
 g/gBq/LiSGWzbhI6cTpZlOgbhqHQ5QAtrIcyYtEIaQW3UqBO2CriUkKZEYqUNaN5YtxyJA9o1
 4AYGz123R0K1M0nV/CVokish0rTplR8hUTBBNcYil0wXFN3H0NGUuR7akoRh90kt6PP0N+Hd3
 SxPOCvNEUJwUDlAlvTXd8YKbauXqLfgP/LqBJ5PQpxGQL/ohYj0U+92425//QPyKG8ECP3tll
 YW0twvGX1yLUlqGpDIa2KgIFGBCCiRzQiqPndraIHLP0rKXu9lLZLRFNCfH1pCTq3fUQrmVIG
 b8TsFNQvNMYVq9y2rCqkauKbyUTgpQI5Nb4ivJHeLN5IPpFSAaT2B/GjEDySTT8KbNTM1uNQf
 tRVURfgqAWr08oq1k
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Convert the last few remaining mmap_sem rwsem calls to use the new
> mmap locking API. These were missed by coccinelle for some reason

Will the clarification of this software situation become more interesting?


> (I think coccinelle does not support some of the preprocessor
> constructs in these files ?)

I suggest to omit this information from the final change description.
Would you like to help any more to find nicer solutions
for remaining open issues?

Regards,
Markus
