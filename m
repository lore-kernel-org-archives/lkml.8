Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ADCC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B592078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Wc0yli4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgD0Qul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:50:41 -0400
Received: from mout.web.de ([217.72.192.78]:52485 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgD0Quk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588006222;
        bh=2eK+WZlVN7toR8cmjhDTJHQvtdzlRS7FQGhss/VirCA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=Wc0yli4GGpzcm8kG6O1ueAZCZ3ohLljVj/KKmN8xTGq8kEZ6HxopREIsrwANl8ZyL
         /tqr5Ls+NqeGeIlm/otCQKb8a9f6ee4uROU7W2myGzyudtK69uA8OB6EogGFt5AUn/
         76a652Z8lbMcVTKhMvPRHbuIrq3P3OYEGT0ZpUr8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.190.48]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEeC-1jQxF81LrM-00FQ6z; Mon, 27
 Apr 2020 18:50:22 +0200
Subject: Re: [PATCH v2] checkpatch: add dedicated checker for 'Fixes:' tag
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>
References: <20200427145332.GA18830@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Message-ID: <0bded90c-cc66-bd12-7192-4bd75e72f678@web.de>
Date:   Mon, 27 Apr 2020 18:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427145332.GA18830@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nKtdP+UjWYUlD2mGfW+04Z9clbpiWW5Tbd2pdbDMBOMlOoBMzJo
 rtc3c99bLNy7LvixWhd7Ns4fswIDebA94O1cyJgDuMZyumRxdEErfRTeJJ9prMGTXfaVUNd
 E2KZNRgBkGjI3BRTxz9gXP233lp3LBVfZ+AA0EIyUx0kbTInhjQTzSw0OGGUY5Q0qI5bHWS
 viU0WzqpQHyE4BNGE5LjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1rJjO5J5onQ=:5UIxiw4XNeKby3I3GOuVes
 UTkiLDMcQ6iqkpL4F5bvq7j6tODZ1nqbY0YqZTmfZGk8IXaqTSpaFc1B97xiBRYjvkY/FQS53
 lmCqW9HIRLq4JFxiplAVXJxv7FECT94jzPfqHy8DwvN56MGwCjs0GhajhdUHwnAuST/8gfXF7
 oxKCQ9xdNLVpKR/OrVdb8DI5DRO39OqbMwFJffZYUlwwCXqPdwQOZgIhW3iPenn/WZvwR/PFj
 Pd1iXYdxFi8Fo2+aUjIlWB6Lja92OCsHU8dyngv+chGqe/AA1XwBipBFtW/AUQ//YQ0nejO7Q
 sYqGuWVtgng4OV7XZ6++tcb4j8nUJLA/gWF5FUiEa1mo5vGFdwypLtoTVkb8LjW1ckApgBSwl
 aMFLDpE99fn4FmoObiuDjt13u8XAfH10xnaebihTyq7gqeXCuVAyIhpuqStXf7LHUBZvsnbtI
 gTZcb9OEOKeeYUta5bWPAZqOO4pb+LunMkxaWfY5pGNrytPcf1C1sp9bSeOtxgeJkcw0D+wrW
 /lAG2wFYUYVqMkr7z59GF8m8nGjRT+5AhFup5qS4IRMb+nG/FX0L4okiF8Efih8+hTWpgx8t2
 ez/le+MicsmIpUd838etLawZfPhjog/W6CIdWD2FVOQeecboGzl7wTqTcz6S9Yp8Hehwqe280
 P56F0nPMfqhEHelM8lpF8he7+fweFIpiVJHltUnp/6lbZ3+hPEs+N+S9h/ZPOxgAhfBk8OrzQ
 lFVVrc6gzH9eD8VbSqvvcnKUqhA1HDe2vnl3+wQKxuVUc7jCC8RDpShH2yXTgEC1aIkg6Zq+w
 UbVd/CgKFWbIooh5PbQEkikCyJiXAHMLptEd0ck5T3gffGUk5VSstBbIjJG2Rehj6ZcMj36zX
 jnTc5xxZaOWWZGLuWwcqyIuYkNSXJ1byWouo15ZVEH6C3MqC7sSUVBMy/3F6cDZqD4nGIc27W
 pA44Q0ut41IOgijGhLHHeolEQlI5/KMNmgGIKJKE+L6k7sCXRnX9X73PqdIo0IO98iy6JD8qO
 pberV+4Rv3XwFiEoEEhJVNu2s5SzagDwM3Mrh+QrFOGLI+qVEWg66lB00JnbUsNqh1YKqcqtx
 y+TexT5Pf1cIzq/p6iRIqnpU0gRoPkLPFOr7pM6kgFHFbwHNnwxp+LAg/6wwxqd0i8Qil8x3g
 t95+9fxb+iojPKiyDsIEWRDUAQIs7QngAMc/5eZY7tNX1kTU6SkOpWt6NhihjEiwICppOdgYg
 XTwTqK7b7ETUy/aNe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> According to submitting-patches.rst, =E2=80=A6

I find that the reference to this document can trigger further considerati=
ons
also for this evolving change description.


> "
> Do not split the tag across multiple
> lines, tags are exempt from the "wrap at 75 columns" rule in order to si=
mplify
> parsing scripts
> "

Can it be nicer to use typographic quotation characters together with elli=
pses?


> And the current 'Fixes:' checker in "# Check for git id commit length an=
d
> improperly formed commit descriptions" doesn't check for invalid commit =
id

Should this =E2=80=9Clink=E2=80=9D refer to a known check name?


> length, so this patch adds dedicated checker to fix these issues.

Would you care to transform this information into an imperative wording?


=E2=80=A6
> +++ b/scripts/checkpatch.pl
> @@ -2820,7 +2820,7 @@ sub process {
=E2=80=A6
> -		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
> +		      $line !~ /^\s*fixes:\s*(?:[0-9a-f]{6,40})\s*(?:.*)/i))) {

I guess that the clarification around the relevance of word boundaries
will become also more interesting.

Will it become relevant to check if a provided change identification
can actually be resolved to the desired commit?


> @@ -2979,6 +2979,13 @@ sub process {
=E2=80=A6
> +				ERROR("FIXES_TAG",
> +					"please use the 'Fixes:' tag with at least the first 12 characters=
 of the SHA-1 ID, and the one line summary(no across multiple lines)\n" . =
$herecurr);

* How do you think about to start this message with the word =E2=80=9CPlea=
se=E2=80=9D?

* Is the text =E2=80=9Csummary(no across=E2=80=9D still questionable?

* Will there be a need to explicitly describe the data format
  for the summary specification also at this place?

Regards,
Markus
