Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5E9C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA93B2137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgEARVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:21:52 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgEARVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:21:52 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MdNLi-1ivVaX3lvE-00ZKwD for <linux-kernel@vger.kernel.org>; Fri, 01 May
 2020 19:21:50 +0200
Received: by mail-qt1-f169.google.com with SMTP id o10so8451171qtr.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:21:49 -0700 (PDT)
X-Gm-Message-State: AGi0Pubx8GtEgO5nx0Pk/5h+25OmTQu1lqj0jfh2r291O0LjqE5v7l+f
        fOmxzrO5pUEqwGJ0cARw+BqA3ygCQA4ga28CByI=
X-Google-Smtp-Source: APiQypKkN+sKlNzysiOEOsVSd4anzykdWHZg5+7nBglHrDHt0A9GzTlTu1qLibzh3t9ghfXXsIT8PsHgXttxNBQywiY=
X-Received: by 2002:ac8:12c2:: with SMTP id b2mr4862105qtj.7.1588353708743;
 Fri, 01 May 2020 10:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
In-Reply-To: <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 May 2020 19:21:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3exNWHzv7pyV4yvn2hPxUswzSF=G3UJ=evykT5bjfEsw@mail.gmail.com>
Message-ID: <CAK8P3a3exNWHzv7pyV4yvn2hPxUswzSF=G3UJ=evykT5bjfEsw@mail.gmail.com>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vo/v/0bKXqIdpCY8E1lFX3kTdTOYd/DVjgsc/jIDyQUxS+7s43Y
 QTLZVKrvzm5481H0BOpNcV+jtt4jfMmb2APSwWn8hbokDt+rzApHdR4CIZyFMUNDAuUNqUC
 G9obpm9SYl2eEU0VloJl+QCF/zYUFDCp/JggOB600zpO+NdN2sJ8/5gS+dLq/tSAKDVhHwy
 R0MSikRyXZ//Q250v9q6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F8lzdH4fmUo=:xi+6zSVT9BN2zhDq6B4hg3
 G6VyI0Dy4oHYQSsQD/7/CJVTGajV607v+oldq9iIaZmtxX6s1WhICcUO3tvCXMpE1rM1L72TJ
 funwjaW9YkUKl+25dnR8j2cxTHpWZFbNc7g9//xHEj3PUW0RO0ze97wfEwi0whyTdOGMFFSxE
 33jQeBa37/+M4wDPMk0nT8rZxG5P2cE3qwkFZTh8VZ64HAmyRhlB7WJjrjg+TIDsYm+dWB8TF
 JNIbMxyVNIdakFrlo8XaRewKq8JYpEfp53/eZpMibvGnIHoS/XxGE8KxVDwdnrQHYFuI4mi5I
 roWHnIgRK4sB/wx5gP+PhwL1uJXPWvjO0SYd8IabDbJ8yaYT7dk+jRC/LO3fysrmQJZy+SwEZ
 ACeBg3fVe2igrqaYi94LR7dvuhFgscTnv4MDMy2ZmFd3vrcYsnaLBnnhTZizg/54DcuS5QbqK
 9Znp6TG1FM1JObsOLJZ8IUZg/+r68c62qxy0I+2QrwLX3dOGeM1e2pmCZ73dL1rhydOBlaZzx
 Emg6YElFO4Yu06AExCdIb75VGtcvO8vBDMS64bSDnPbPQKGOxd74Wu1RvqtA40CFNc9NAPIR2
 1otoaC+KAUyJdBflWS2cQG/02/VK0ERNr+Dmv3zxtru9ZoyiTsBZYg7iCNBaX/Z5ikSd9uZYK
 IQ6oUDJlm/oW3vD109g1cj/joUvW5DVfRJg7SzwaOwbSeu6r0PbA2Z9xabvcmXoRVafx5nltj
 474S1EyZUBJE7SkAiIDe7GAcxr3SOn7B2Vd9AzBWQJN+5x5AGWdF2K0/LS9wgKnauaMWkw3ky
 pIES83d07sIs8X+bf6N+kHw795ColvYZEmEqK19yBzClo2zvOw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 4:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Apr 28, 2020 at 4:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
> drivers/media/dvb-frontends/rtl2832_sdr.o: warning: objtool: .text.unlikely: unexpected end of section
> drivers/media/dvb-frontends/rtl2832_sdr.o: warning: objtool: rtl2832_sdr_try_fmt_sdr_cap() falls through to next function
> rtl2832_sdr_s_fmt_sdr_cap.cold()

I had a look at this one and found this happens when  gcc optimizes this loop

        memset(f->fmt.sdr.reserved, 0, sizeof(f->fmt.sdr.reserved));
        for (i = 0; i < dev->num_formats; i++) {
                if (formats[i].pixelformat == f->fmt.sdr.pixelformat) {
                        f->fmt.sdr.buffersize = formats[i].buffersize;

formats[] is a static array, so if num_formats is larger than
ARRAY_SIZE(formats),
it gets into undefined behavior and stops emitting code after the call to
__sanitizer_cov_trace_pc.
https://godbolt.org/z/h9Gx3S shows a reduced test case:

struct v4l2_sdr_format {
  int pixelformat;
  int buffersize;
};
struct rtl2832_sdr_format {
  int pixelformat;
  int buffersize;
};
static struct rtl2832_sdr_format formats[] = {{}, {}};
struct rtl2832_sdr_dev {
  int num_formats;
};
void rtl2832_sdr_try_fmt_sdr_cap(struct v4l2_sdr_format *f,
                                 struct rtl2832_sdr_dev *dev) {
  int i = 0;
  for (; i < dev->num_formats; i++)
    if (formats[i].pixelformat)
      f->buffersize = 0;
}

With this source change, the warning goes away:

diff --git a/drivers/media/dvb-frontends/rtl2832_sdr.c
b/drivers/media/dvb-frontends/rtl2832_sdr.c
index 60d1e59d2292..faae510985e0 100644
--- a/drivers/media/dvb-frontends/rtl2832_sdr.c
+++ b/drivers/media/dvb-frontends/rtl2832_sdr.c
@@ -1150,7 +1150,7 @@ static int rtl2832_sdr_s_fmt_sdr_cap(struct file
*file, void *priv,
                return -EBUSY;

        memset(f->fmt.sdr.reserved, 0, sizeof(f->fmt.sdr.reserved));
-       for (i = 0; i < dev->num_formats; i++) {
+       for (i = 0; i < min(dev->num_formats, NUM_FORMATS); i++) {
                if (formats[i].pixelformat == f->fmt.sdr.pixelformat) {
                        dev->pixelformat = formats[i].pixelformat;
                        dev->buffersize = formats[i].buffersize;
@@ -1178,7 +1178,7 @@ static int rtl2832_sdr_try_fmt_sdr_cap(struct
file *file, void *priv,
                (char *)&f->fmt.sdr.pixelformat);

        memset(f->fmt.sdr.reserved, 0, sizeof(f->fmt.sdr.reserved));
-       for (i = 0; i < dev->num_formats; i++) {
+       for (i = 0; i < min(dev->num_formats, NUM_FORMATS); i++) {
                if (formats[i].pixelformat == f->fmt.sdr.pixelformat) {
                        f->fmt.sdr.buffersize = formats[i].buffersize;
                        return 0;

Do we consider this expected behavior on gcc's side, or is it something
that should not happen and needs a gcc bug report?

       Arnd
