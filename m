Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C6AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958292067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459213;
	bh=Zn8v6aEP6tL1vqPAVc1/RoyHVKZpU6doz5G/hdNXSlM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pwNx3yvTSc/ISpiXq0NWpT6/CHW5B9OehE4zz2PHNcVvQyMWUhWxoWI04gILagRDI
	 9KRJbZRjWgkcMyhTkxcR6yWaqJHrVufTXfIr6G3IkAPbCvI5qc68cG/M2Qe9Jrs5eq
	 Mcbr0VZC+DQn3qYB1iilX8av6yePXnCBBaf5R2kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbgF2Td1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733229AbgF2Tco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:44 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D144C031403
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:03:08 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h22so11723365lji.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYkNQhrQ73+DS4WcbWOixgqg1YKTSEfzrd0va8TDW4k=;
        b=SHNChlvA5r4ptrqnY0375jaIMSmvEUuePRAFPsJVpUJjqSO43KPb6TbhuszrL13MT4
         MQFaOoee64c/nkUbHHR634GEPTh6OW0biDklGP/Y9v4kNF7WCrynlT5MsldrS6obVw6Y
         MwD2RfeEaFimUe1/u2drdf3DTN+8YiVBYT7PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYkNQhrQ73+DS4WcbWOixgqg1YKTSEfzrd0va8TDW4k=;
        b=F0m9SDN3hvA90hlXpPdniUqCC03xGlLpI+rD6ecpLa8aZV6Ag2zoNHbBxp8HHGGV2L
         DqN4OVaoh/L2sPxihk2cwFNP4a+Q5m5lNGS//oewULJICCX0YRMB4e+kFEctipDUAHXQ
         z6Xgr2AMfys+nmOuFGRcl4KD/EtgV4vs+w3+qzLUwRWX57fMq7HcSiXBN9F2TjK1Ew7L
         v1PdQgxklbJ+p3hGPj2yhfJqrc0OJiXE0iQEjGjH4O7zE14TR9H+Pk924d45bvt6+8NC
         JB2RtbLu07szOrwk4dlYT18Ui9Nollg9VL1xRplh88xl66AOvIkagzLdUni+A9U+8ZER
         NptA==
X-Gm-Message-State: AOAM531qxXhNkgNOY+X4g4c+hqQNOWUZE/I4USZ84IsZxRrN2yZOA0jy
        g+MBay63wFRf6HAgDg5ynRLtEIqb9PI=
X-Google-Smtp-Source: ABdhPJxIgSpBH8tXVTSo5DElCW8FVJI/RVYe9z/u8U5SUQoqgfUX2i4fKog9DbLNI/PorSt+DRQ6rQ==
X-Received: by 2002:a2e:b55a:: with SMTP id a26mr4021893ljn.349.1593450186338;
        Mon, 29 Jun 2020 10:03:06 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id r70sm48388lff.97.2020.06.29.10.03.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 10:03:05 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id n23so18910627ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:03:04 -0700 (PDT)
X-Received: by 2002:a2e:5c02:: with SMTP id q2mr9066033ljb.285.1593450184298;
 Mon, 29 Jun 2020 10:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
 <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com> <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
 <20200629152912.GA26172@lst.de>
In-Reply-To: <20200629152912.GA26172@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Jun 2020 10:02:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_Br5dQt0GnMjHooSvBbVXwtGRVKQNkpCLwWjYko-4Zw@mail.gmail.com>
Message-ID: <CAHk-=wj_Br5dQt0GnMjHooSvBbVXwtGRVKQNkpCLwWjYko-4Zw@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000034779e05a93c083a"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000034779e05a93c083a
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 29, 2020 at 8:29 AM Christoph Hellwig <hch@lst.de> wrote:
>
> So based on that I'd rather get away without our flag and tag the
> kernel pointer case in setsockopt explicitly.

Yeah, I'd be ok to pass that kind of flag around for setsockopt, in
ways I _don't_ want to do for some very core vfs thing like 'read()'.

That said, is there no practical limit on how big "optlen" can be?
Sure, I realize that a lot of setsockopt users may not use all of the
data, but let's say that "optlen" is 128, but the actual low-level
setsockopt operation only uses the first 16 bytes, maybe we could
always just copy the 128 bytes from user space into kernel space, and
just say "setsockopt() always gets a kernel pointer".

Then the bpf use is even simpler. It would just pass the kernel
pointer natively.

Because that seems to be what the BPF code really wants to do: it
takes the user optval, and munges it into a kernel optval, and then
(if that has been done) runs the low-level sock_setsockopt() under
KERNEL_DS.

Couldn't we switch things around instead, and just *always* copy
things from user space, and sock_setsockopt (and
sock->ops->setsockopt) _always_ get a kernel buffer?

And avoid the set_fs(KERNEL_DS) games entirely that way?

Attached it a RFC patch just for __sys_setsockopt() - note that it
does *not* change all the low-level setsockopt callers to just do the
kernel access instead, so this is completely broken, but you can kind
of see what I mean.

Wouldn't this work? In fact, wouldn't this simplify all the setsockopt
places that now don't need to do "get_user()" etc any more?

It would be better if we could limit "optlen" to something sane, but
right now it just does a kmalloc() of whatever the user claims the opt
len is..

                    Linus

--00000000000034779e05a93c083a
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kc0r32ze0>
X-Attachment-Id: f_kc0r32ze0

IG5ldC9zb2NrZXQuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL25ldC9zb2NrZXQuYyBiL25ldC9zb2NrZXQuYwppbmRleCA5NzY0MjZkMDNmMDkuLjM5
MDYwYTVmMGNhYSAxMDA2NDQKLS0tIGEvbmV0L3NvY2tldC5jCisrKyBiL25ldC9zb2NrZXQuYwpA
QCAtMjA4NiwyNSArMjA4NiwzNyBAQCBTWVNDQUxMX0RFRklORTQocmVjdiwgaW50LCBmZCwgdm9p
ZCBfX3VzZXIgKiwgdWJ1Ziwgc2l6ZV90LCBzaXplLAogICovCiAKIHN0YXRpYyBpbnQgX19zeXNf
c2V0c29ja29wdChpbnQgZmQsIGludCBsZXZlbCwgaW50IG9wdG5hbWUsCi0JCQkgICAgY2hhciBf
X3VzZXIgKm9wdHZhbCwgaW50IG9wdGxlbikKKwkJCSAgICBjaGFyIF9fdXNlciAqdV9vcHR2YWws
IGludCBvcHRsZW4pCiB7Ci0JbW1fc2VnbWVudF90IG9sZGZzID0gZ2V0X2ZzKCk7Ci0JY2hhciAq
a2VybmVsX29wdHZhbCA9IE5VTEw7CiAJaW50IGVyciwgZnB1dF9uZWVkZWQ7CiAJc3RydWN0IHNv
Y2tldCAqc29jazsKKwljaGFyICpvcHR2YWw7CiAKIAlpZiAob3B0bGVuIDwgMCkKIAkJcmV0dXJu
IC1FSU5WQUw7CiAKKwkvKiBDYW4gd2UgaGF2ZSBzb21lIHVwcGVyIGxpbWl0IG9uIG9wdGxlbiAq
LworCW9wdHZhbCA9IGttYWxsb2Mob3B0bGVuLCBHRlBfS0VSTkVMIHwgX19HRlBfTk9XQVJOKTsK
KwlpZiAoIW9wdHZhbCkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwlpZiAoY29weV9mcm9tX3VzZXIo
b3B0dmFsLCB1X29wdHZhbCwgb3B0bGVuKSkgeworCQlrZnJlZShvcHR2YWwpOworCQlyZXR1cm4g
LUVGQVVMVDsKKwl9CisKIAlzb2NrID0gc29ja2ZkX2xvb2t1cF9saWdodChmZCwgJmVyciwgJmZw
dXRfbmVlZGVkKTsKIAlpZiAoc29jayAhPSBOVUxMKSB7CisJCWNoYXIgKmJwZl9vcHR2YWwgPSBO
VUxMOworCQljaGFyICp1c2Vfb3B0dmFsOworCiAJCWVyciA9IHNlY3VyaXR5X3NvY2tldF9zZXRz
b2Nrb3B0KHNvY2ssIGxldmVsLCBvcHRuYW1lKTsKIAkJaWYgKGVycikKIAkJCWdvdG8gb3V0X3B1
dDsKIAogCQllcnIgPSBCUEZfQ0dST1VQX1JVTl9QUk9HX1NFVFNPQ0tPUFQoc29jay0+c2ssICZs
ZXZlbCwKIAkJCQkJCSAgICAgJm9wdG5hbWUsIG9wdHZhbCwgJm9wdGxlbiwKLQkJCQkJCSAgICAg
Jmtlcm5lbF9vcHR2YWwpOworCQkJCQkJICAgICAmYnBmX29wdHZhbCk7CiAKIAkJaWYgKGVyciA8
IDApIHsKIAkJCWdvdG8gb3V0X3B1dDsKQEAgLTIxMTMsMjcgKzIxMjUsMjMgQEAgc3RhdGljIGlu
dCBfX3N5c19zZXRzb2Nrb3B0KGludCBmZCwgaW50IGxldmVsLCBpbnQgb3B0bmFtZSwKIAkJCWdv
dG8gb3V0X3B1dDsKIAkJfQogCi0JCWlmIChrZXJuZWxfb3B0dmFsKSB7Ci0JCQlzZXRfZnMoS0VS
TkVMX0RTKTsKLQkJCW9wdHZhbCA9IChjaGFyIF9fdXNlciBfX2ZvcmNlICopa2VybmVsX29wdHZh
bDsKLQkJfQorCQl1c2Vfb3B0dmFsID0gYnBmX29wdHZhbCA/IGJwZl9vcHR2YWwgOiBvcHR2YWw7
CiAKIAkJaWYgKGxldmVsID09IFNPTF9TT0NLRVQpCiAJCQllcnIgPQotCQkJICAgIHNvY2tfc2V0
c29ja29wdChzb2NrLCBsZXZlbCwgb3B0bmFtZSwgb3B0dmFsLAorCQkJICAgIHNvY2tfc2V0c29j
a29wdChzb2NrLCBsZXZlbCwgb3B0bmFtZSwgdXNlX29wdHZhbCwKIAkJCQkJICAgIG9wdGxlbik7
CiAJCWVsc2UKIAkJCWVyciA9Ci0JCQkgICAgc29jay0+b3BzLT5zZXRzb2Nrb3B0KHNvY2ssIGxl
dmVsLCBvcHRuYW1lLCBvcHR2YWwsCisJCQkgICAgc29jay0+b3BzLT5zZXRzb2Nrb3B0KHNvY2ss
IGxldmVsLCBvcHRuYW1lLCB1c2Vfb3B0dmFsLAogCQkJCQkJICBvcHRsZW4pOwogCi0JCWlmIChr
ZXJuZWxfb3B0dmFsKSB7Ci0JCQlzZXRfZnMob2xkZnMpOwotCQkJa2ZyZWUoa2VybmVsX29wdHZh
bCk7Ci0JCX0KKwkJaWYgKGJwZl9vcHR2YWwpCisJCQlrZnJlZShicGZfb3B0dmFsKTsKIG91dF9w
dXQ6CiAJCWZwdXRfbGlnaHQoc29jay0+ZmlsZSwgZnB1dF9uZWVkZWQpOwogCX0KKwlrZnJlZShv
cHR2YWwpOwogCXJldHVybiBlcnI7CiB9CiAK
--00000000000034779e05a93c083a--
