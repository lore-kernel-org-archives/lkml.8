Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B74C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DEB2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="U7YMjK1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgFOPLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:11:22 -0400
Received: from mout.web.de ([212.227.17.12]:32997 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbgFOPLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592233848;
        bh=kewYcNlx9u4ehFUVrYtEia6YoZTBtdSfH1Eo75yhOu4=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=U7YMjK1NM8/0UDWLLPhGKwe1GSbUZFFZ19WnsE0SlQnfPGsey+cpc4//oJ7geNPZf
         g6DMDCxHe9WsnWdrChRJRwOGT61Umf7xvETz7GmQIDwoUNALlkVJRpAM1qbDY+lpvd
         VLKKmJyLupff51PUMeUhsi673B3391A8s5jTFSok=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.107.236]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmuAa-1jH1FT3sWS-00h6O7; Mon, 15
 Jun 2020 17:10:48 +0200
To:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tracing/probe: fix memleak in fetch_op_data operations
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <89f42852-80ef-1634-68fe-b7f686f8ce59@web.de>
Date:   Mon, 15 Jun 2020 17:10:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vi7WLM5/T85hSfNSI1p9TaeM1q7TzworEPsm+qyWP9dxAYCvg4v
 5uWtBDrzPycPqqtS1ucqgHO44lWi6eDEz3FlpyKA9umfz1yDl1+cSE0xb1D0HL3n9XJs4qS
 VUB1j1NsLYU0zsRt3OG/d3vtpDcesyKT0SRmzaY8QUItCjE32oczXIGUin/CUZcyjT2IXrI
 +Ax/dYJTuJCzPNKjnCEfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7FDhM/dBy1A=:0UEFNAr+lCez8EAkR9205S
 Wk9MR0u90t21g+/nLu3rMX3HUFjZAQ90ejg0OLxkue9KxEsbJn7tjswVvAAgk2QNVJMU9R+PE
 pE4LBPkAft6LrUaqPyV2fclsdTD6DFFakJT6FIrbr5aMB8Y4z8gdAE6Q9BluQJfbwT7H75mee
 VyQT2gd+0MM9O8kmuS9ZgQyWn2WoyBC869gPuD9lI/YEIWzT//yUehADYUU9IfGCVoO6cPatx
 I9cfmK4cUBudm+Eo7USDqAAa99Jov4bT0LKz6ELW6D0PI7YVMrx5+qo1TNm2wi7tq7XhCd75C
 WU/nV1vpcKZtqvngVeXmytFAiWV8AIbNccgCkzJRAbUEq+cfZnE/d7RotLia8LRA/DVZi4y7K
 QbwYMx/eTLdLa/i5HeuAtfuKMBorY2PKTjlzctcGq4l9ebkfv26Ryz36tEiN1/pKRGcMWGdX5
 U0IxOs8to96j3XLhpjBDaSZfNp3iAmMLqzho3t5sQipE0jdeo96nn6uYS4B/a6tihaiUeGKsy
 rdUqQj7Qo+lATSg6iBHfR2wWLdnuPhtiNZwhpt1e5EwxnAChVvZzs0WkYZ+emgz0rXQb9TS58
 vrx347RXv8LNv9kwhIIB4bejoGwSpRxabZLEceOWS6PMxjtf/u1aarvO/6uJ0Bg92luEjq6IR
 R9529iveTGwikHjhfTc0RQgipsRUx8zIScgWyjT9ILTM9dK5eEHGG1vhBrzDWB7udzmcqGezG
 KyFgsgHK0IZnBVy8AznpRPvBxS9LWoYuwZ6JPImAEn4TuZpAXz49A/wZykKsHcVoEXT4gzTWT
 jy74MauizU4YCj4NhvdQB8OcyUqZsEZmE42fZuZz5GPIfjeapYHnyS/kC8xiReABpWEWt9zBR
 1gDCwI8/JO1ODyoY8oHMbsL0jdbkDPyQJvQbcRS3MUPlnHvQRadKmGSqJ/YDK7CP3NMijGTk9
 l5kVoWizs0l6VsbIMuCrszqaPjJu7V4GpL87qhKsqZi/q9mmVS57Nzx3iYGO+RLF4UNGaTMLS
 94FDDjwxx5VdgS+GonkjmX8FASw+z/nQ2vKVPk0SJvNy1aFcdn+Y77vKHBt0q47Qa/GlMgvNj
 RvyjCVbEqo9SWegaT+1zi6f9xovobLthnmPJIqM9VENxyEUSfnqpay4x0Ar1mGu+ZFa2lraTB
 Bwc+MLsPIXeSu2UK5LEOWXzs3ZexRoteGv22yfN2lv1tPS76BWGv6HehAxsDELifljJHs7O5Z
 Yksem6de9umIY/ln5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> Post parse_probe_arg(), the FETCH_OP_DATA operation type is overwritten
> to FETCH_OP_ST_STRING, as a result memory is never freed =E2=80=A6

How do you think about to use the term =E2=80=9Cmemory leak=E2=80=9D in th=
e patch subject?

Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit message=
?

Regards,
Markus
