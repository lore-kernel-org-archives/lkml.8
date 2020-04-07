Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE032C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924A020768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgDGAKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:10:24 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:40226 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDGAKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:10:24 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2020 20:10:21 EDT
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 28D315FF04
        for <linux-kernel@vger.kernel.org>; Tue,  7 Apr 2020 00:03:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id m9qm7eJJBROw for <linux-kernel@vger.kernel.org>;
        Tue,  7 Apr 2020 00:03:04 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-46-244-252-139.dynamic.mnet-online.de [46.244.252.139])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Apr 2020 00:03:04 +0000 (UTC)
Message-ID: <ce8097694ddfab616616f8f81521495d99c74416.camel@scientia.net>
Subject: great CPU temperature increase from 5.2 to 5.5 ... and when using
 intel_pstate
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-kernel@vger.kernel.org
Date:   Tue, 07 Apr 2020 02:03:03 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey.


For several months now, I've been chasing a tremendous heat increase
(CPU/GPU) respectively power usage on my notebook.

It basically started after upgrading from 5.2 to 5.3, at least I
haven't explicitly noted any grave changes from before 5.2 to 5.2.
The issue (actually there might be several) persists until at least 5.4
and 5.5.

Things are so bad, that when just type this mail,... that I can hear
the fan go up considerably (and temps up to 90°C) just by typing the
mail in the mail client (while it goes back to - still insane - 65°C
idle, when not typing... ok idle here(!) is with firefox running).
Similar things when I scroll through a terminal window, Alt-Tab cycle
between windows, and so on.


Testing is a bit difficult for me, as I couldn't come up with an easy
way to reproducibly generate real world load (like this typing, or
scrolling terminal windows), yet I tried to do an extensive test
series, which I think will illustrate some things.


Not really sure what the normal average or idle temps of that CPU are,
but I guess getting at average >80°C by just typing shouldn't be the
case.




1) Previous tests
*****************
When first searching for the reason of the temperature increase, I've
had opened several tickets:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=945055
https://lore.kernel.org/lkml/d05aba2742ae42783788c954e2a380e7fcb10830.camel@scientia.net/

Finally to find (by coincidence):
https://gitlab.freedesktop.org/drm/intel/issues/614
when reporting:
https://gitlab.freedesktop.org/drm/intel/-/issues/953
myself.

At first I thought #614 would be the bug, but the fix for that went
into 5.5-rc, and in fact, with 5.5.x I do see the GPU entering RC6
sleep states again, yet the temperature of my system is still crazy.




2) Testing Environment
**********************
(for these new tests here)
- Fujitsu Lifebook U757
- most recent BIOS version (1.25) in the tests below (I've had used an
  older one in previous tests from the links)
- 32GB memory, some Sandisk SSD
- Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz
- microcode: sig=0x806e9, pf=0x80, revision=0xca
- Debian sid, all packages (unless some totally unrelated stuff at
  their newest versions in unstable)
- all used kernels are stock kernels from Debian
- I do use full dm-crypt encryption of the system, but that shouldn't
  be a cause for the problems, I guess.
- in my /etc/sysfs.conf I have:
  devices/system/cpu/intel_pstate/no_turbo = 1
  basically since I have that laptop... with turbo enabled I always
got 
  these:
  Apr  5 18:27:07 heisenberg kernel: [ 9884.510420] mce: CPU3: Package temperature above threshold, cpu clock throttled (total events = 2609)
  Apr  5 18:27:07 heisenberg kernel: [ 9884.510422] mce: CPU1: Package temperature above threshold, cpu clock throttled (total events = 2609)
  Apr  5 18:27:07 heisenberg kernel: [ 9884.510465] mce: CPU0: Package temperature above threshold, cpu clock throttled (total events = 2609)
  Apr  5 18:27:07 heisenberg kernel: [ 9884.510467] mce: CPU2: Package temperature above threshold, cpu clock throttled (total events = 2609)
  Apr  5 18:27:07 heisenberg kernel: [ 9884.511427] mce: CPU3: Package temperature/speed normal
  Apr  5 18:27:07 heisenberg kernel: [ 9884.511430] mce: CPU0: Package temperature/speed normal
  Apr  5 18:27:07 heisenberg kernel: [ 9884.511431] mce: CPU1: Package temperature/speed normal
  Apr  5 18:27:07 heisenberg kernel: [ 9884.511436] mce: CPU2: Package temperature/speed normal
  => so for the tests with ipntel_pstate not being disabled, turbo mode
     was always disabled




3) How tests were made
**********************
I've tested with the following combinations:
- kernels 5.2.17 and 5.5.13
- with and without intel_pstate=disable
- with Cinnamon and GNOME Shell in classic mode

For all tests the notebook was placed in the same position and ran with
the same commands for tests, no other major processes (like firefox or
so) were running, just the respective bare desktop environment
(cinnamon or gnome shell classic), cron/anacron were stopped.

I always took temperature measurements with the output from sensors and
CSV output from powertop (which contains all the sleep states and high
energy users).

Temperature and powertop measurements were started at basically the
same time. powertop running for n iterations each 20s.
But since powertop takes a while to start the temperature measurements
are effectively shorter.


a) deep-idle
For these tests I've waited very long (like 5 minutes or more) for the
system to cool down.
Measurements with, e.g.:
export NAME="5.2.17/ipstate-disable/thermald-no/gnome-shell-classic/deep-idle" ; timeout 80 sh -c "while true; do sleep 1; sensors; done | grep °C > ${NAME}.temp"
and
export NAME="5.2.17/ipstate-disable/thermald-no/cinnamon/deep-idle" ; powertop -i 4  --csv=${NAME}.powertop.csv


b) idle
Basically the same as (a), just not waiting so long to cool down.
Effectively I've always produced some load (with the fan and CPU temp
noticeably going up over 65°C), then stopped and waited for a minute.


c) winmove
After waiting a while for the CPU to cool down, starting the
measurement and then moving a terminal window fast and constantly in
circles over the whole screen.

The measurement is split in 3 phases. During warmup and main I've moved
the window like crazy. As soon as the cooldown phase began, I've
stopped that and did nothing more until the measurement finished.

Measurements with, e.g.:
export NAME="5.2.17/ipstate-disable/thermald-no/cinnamon/winmove" ; powertop -i 3 --csv=${NAME}.warmup.powertop.csv ; beep ; powertop -i 4 --csv=${NAME}.main.powertop.csv ; beep ; powertop -i 4 --csv=${NAME}.cooldown.powertop.csv
export NAME="5.2.17/ipstate-disable/thermald-no/gnome-shell-classic/winmove" ; powertop -i 3 --csv=${NAME}.warmup.powertop.csv ; beep ; powertop -i 4 --csv=${NAME}.main.powertop.csv ; beep ; powertop -i 4 --csv=${NAME}.cooldown.powertop.csv


d) verify, verify-data
That measure when running a poorly written shell script of mine, the
shell script would read a list of regular files from find, and tries to
verify the SHA512 sum of that file, potentially stored as XATTR on it.
The script is poorly written, does quite a number of forks, pipes, and
so on, which seemed good for these test.

Difference between verify and verify-data are directories on which I
let find run.

with verify: I did it on /home/, where many files don't have my hash
XATTRs set

with verify-data: I did it on a dir, where basically all files have
them set an such there's more going into actual SHA512 calculation

Measurements with, e.g.:
export NAME="5.2.17/ipstate-disable/thermald-no/gnome-shell-classic/verifyxattr" ; timeout 160 sh -c "while true; do sleep 1; sensors; done | grep °C > ${NAME}.warmup+main.temp" ; beep
export NAME="5.2.17/ipstate-disable/thermald-no/cinnamon/verifyxattr" ; powertop -i 8 --csv=${NAME}.warmup+main.powertop.csv ; bee


e) mpv-gpu-vaapi
Playing back a:
    Stream #0:0: Video: h264 (High), yuv420p(tv, bt709, progressive), 1920x1080 [SAR 1:1 DAR 16:9], 59.94 fps, 59.94 tbr, 1k tbn, 119.88 tbc (default)
video via:
mpv someVideo.mkv -ao=null
in fullscreen.
.config/mpv/mpv.conf has:
script-opts=osc-deadzonesize=0
hwdec=auto

So the video plays back with:
(+) Video --vid=1 (*) (h264 1920x1080 59.940fps)
 (+) Audio --aid=1 --alang=eng (*) (opus 2ch 48000Hz)
Using hardware decoding (vaapi-copy).
AO: [null] 48000Hz stereo 2ch floatp
VO: [gpu] 1920x1080 nv12
AV: 00:00:01 / 00:36:23 (0%) A-V:  0.000

i.e. gpu and vaapi-copy

I've made two phases:
warmup+main: starting the video, going immediately to fullscreen
cooldown: as soon as the beep for it came, stopping mpv

Measurements with, e.g.:
export NAME="5.2.17/ipstate-disable/thermald-no/gnome-shell-classic/mpv-gpu-vaapi" ; timeout 80 sh -c "while true; do sleep 1; sensors; done | grep °C > ${NAME}.warmup+main.temp" ; beep ; timeout 80 sh -c "while true; do sleep 1; sensors; done | grep °C > ${NAME}.cooldown.temp"
export NAME="5.2.17/ipstate-disable/thermald-no/cinnamon/mpv-gpu-vaapi" ; powertop -i 4 --csv=${NAME}.warmup+main.powertop.csv ; beep ; powertop -i 4 --csv=${NAME}.cooldown.powertop.csv


f) unhide-brute
Running the unhide program in brute mode (using the C version, not the
ruby version).
unhide seems to do a lot of forking, which also seems to CPU to go
crazy in terms of temperature (at least in some cases).

Measurements with, e.g.:
export NAME="5.5.13/ipstate-active-hwp/thermald-no/cinnamon/unhide-brute" ; timeout 240 sh -c "while true; do sleep 1; sensors; done | grep °C > ${NAME}.warmup+main.temp" ; beep
export NAME="5.5.13/ipstate-active-hwp/thermald-no/cinnamon/unhide-brute" ; powertop -i 12 --csv=${NAME}.warmup+main.powertop.csv ; beep




4) Results
**********
For ease of use I've placed all my original test files and derived ones
in a git repo:
https://github.com/calestyo/cpu-tests


At first, I'm just looking at the bare temperatures of the Package,
which I've extracted to ./pack-temps for each of the tests.


I use ips = intel_pstate. in the following



a) deep-idle and idle
cinnamon_deep-idle.svg
=> 5.2 with ips=off runs ~2 °C cooler than 5.5 with ips=on
                         ~4 °C cooler than 5.5 with ips=off
                         ~3 °C cooler than 5.2 with ips=on
=> so from hottest to coolest:
   5.5/ips=off 5.2/ips=on  5.5/ips=on  5.2/ips=off

cinnamon_idle.svg
=> at least it's quite obvious that 5.2 with ips=off runs coolest
  
compared to 5.5 with ips=off it's 4-5 °C...
   compared to 5.5 with
ips=on  it's still quite noticeable in the
                             
beginning (could be testing though)
   it's also noticeable cooler than
5.2 with ips=on
=> so from hottest to coolest:
   5.5/ips=off 5.2/ips=on 
5.5/ips=on  5.2/ips=off
   (at least in the end)


gnome-shell-classic_deep-idle.svg
=> I'd say the results are too close, as one could deduce anything
valuable here,... but  5.5 looks better here (and ips=on looks even
better than having it disabled)

gnome-shell-classic_idle.svg
=> similarly here, the numbers are rather close, but 5.5 with ips=on
looks better... could however depend on the testing and the difference
is only ~2°C


=> One also sees, cinnamon runs considerably hotter than gnome-shell-
classic, none of them have any special applets or so running (just task
bar, workspace switcher, clock).



b) winmove.*
cinnamon_winmove.warmup.svg
cinnamon_winmove.main.svg
cinnamon_winmove.cooldown.svg
=> 5.2/ips=off runs considerably cooler than everything else, something
   around 10-15°C?
=> 5.5/ips=on is clearly the worst
=> 5.2/ips=on and 5.5/ips=off are similar, but 5.2 seems still a bit
   better during warmup and main

In this test it seems:
=> ips=off is considerably cooler/better for each kernel
=> 5.2 is considerably better or at least equal than the best of 5.5


gnome-shell-classic_winmove.warmup.svg
gnome-shell-classic_winmove.main.svg
gnome-shell-classic_winmove.cooldown.svg
=> again, g-s-c seems to do much better than cinnamon, but
=> 5.5/ips=off seems worst
   5.5/ips=on  seems slightly best
   5.2/* in the mid-range
=> but again, the numbers are pretty close so this could be just from
   testing



c) mpv-gpu-vaapi
mpv-gpu-vaapi.warmup+main.svg
=> most likely the blue line (5.2/ips=off/cinnamon) is just bogus,
   could redo it if someone needs
difficult to say something,...
=> all end up at 95-100°C, the ones from cinnamon much faster
=> the only thing I'd personally deduce from these is, that hardware
   acceleration has some severe problem in my setup. I'd have expected
   that playing back a video in fullscreen should be not problem at all
   for the GPU

mpv-gpu-vaapi.cooldown.svg
=> the only clear thing, I guess, is that 5.5/ips=off is worst with
cinnamon



d) verifyxattr and verifyxattr-data

cinnamon_verifyxattr.warmup+main.svg
cinnamon_verifyxattr-data.warmup+main.svg
=> the ones with ips=on are considerably worse...
=> interestingly, for verifyxattr 5.2/ips=off is better with
   5.5/ips=off being the 2nd
=> but for verifyxattr-data (which is ought to be more actual SHA512
   computation intensive and less just-forking), it's vice-versa
   and 5.5/ips=off is better than 5.2/ips=off

=> seems like a hint that forking and/or process switches or similar
   things could cause the temperature issues


gnome-shell-classic_verifyxattr.warmup+main.svg
gnome-shell-classic_verifyxattr-data.warmup+main.svg
similarly:
=> the ones with ips=on are considerably worse...
=> interestingly for verifyxattr 5.2 and 5.5 with ips=off
   are more or less the same
=> but for verifyxattr-data 5.5 is noticeably better


=> these differences cannot be directly explained by some GPU issues,
   at least not to my knowledge, since not much graphical output was
   produced



e) unhide-brute
cinnamon_unhide-brute.warmup+main.svg
gnome-shell-classic_unhide-brute.warmup+main.svg
=> both are nearly the same, except that under g-s-c, 5.5/ips=on
   is noticeable worse than under 5.2/ips=on
=> again, ips=off is *much* better than ips=on
=> 5.2 is considerably better than 5.5


=> these differences cannot be directly explained by some GPU issues,
   at least not to my knowledge, since not much graphical output was
   produced




I think overall conclusions are mostly:
Especially when the temperatures vary greatly, then
- 5.2 is much better than 5.5
- ips=off is much better or at least similar to ips=on





5) the powertop files
*********************
So far I've only taken a glance on them in trying to deduce anything
meaningful.
My hope would have been that some experts here have more experience on
reading them. ;-)


Looking for example at the files from my unhide-brute tests, comparing
5.2/ips=on/cinnamon with 5.5/ips=on/cinnamon, it seemed sometimes that:
Timer;tick_sched_timer
kWork;intel_atomic_commit_work
kWork;free_work

might be offenders... but that's all not so obvious (at least to me).




6) Observations / Other
***********************
a) One thing I've noted sometimes, but not always:
When the system was under "some" load that caused extreme
temperatures... even when I stopped that load, temperatures didn't
always go back.
I mean it's clear that cooling takes a while, but sometimes things went
on for 5 mins or more.


b) Sometimes it might have seemed, that putting the system to suspend
cured the symptoms for a while,... but not always and I haven't tested
this in both kernels and ips=* variations.


c) While writing this email I'm in 5.5/ips=off/g-s-c ...
   (not sure whether ips=on would have been much better)
   The short time idle-temperature is already pretty bad (~65°C)
   (firefox, which seems to be a bad temperature offender, runs
   though).
   Closing FF and the idle temp goes to around ~58-59 (would probably
   go lower if I wait for longer)
   But when I now start moving around the mouse pointer, everything
   stays the roughly same... but I had also situations, where just by
   moving the pointer, temperatures when to 80°C or higher,... stopped
   moving the pointer, and the fell again. 
 
   When I know press&hold a key in a gnome-terminal window, say
   constantly writing "n" to it... nothing changes.

   When I do the same in Evolution's mail compose window...
   temperatures go up to 74°C.
   Correspondingly I see
   /usr/lib/x86_64-linux-gnu/webkit2gtk-4.0/WebKitWebProcess
   going through the roof in powertop.

   Now one could argue there's just something fishy in
   Evolution/WebKit, but from what I remember it's by far not that bad
   (if at all) under 5.2.


d) Similarly, if I just move around the pointer via the touchpad:
   1.71 W     13,2 ms/s     436,3        Interrupt      PS/2 Touchpad / Keyboard / Mouse
   becomes the top power consumer with quite a lot it seems?


e) At least until 5.5 (which fixed the i915 GPU doesn't go to RC6
   issue), I quite often saw the temperatures go crazy, while top
   didn't show that much CPU utilisation.
   Well it's quite clear if the issue was only in the GPU, but even
   with that fixed it still seemed at least sometimes during my tests,
   that I saw extreme temperatures while top didn't show even close to
   100% CPU utilisation.

f) right now, eventstat shows something like this:
Event/s PID      %CPU  PR  NI Task               Init Function                
   81.92   10050   2.1   0   0 WebKitWebProces    hrtimer_wakeup               
   51.95    1600   0.1   0   0 Xorg               it_real_fn                   
   49.95    1600   0.1   0   0 Xorg               hrtimer_wakeup               
   46.95   10050   2.1   0   0 WebKitWebProces    tick_sched_timer             
   32.97    3184   0.7   0   0 gnome-terminal-    hrtimer_wakeup               
   28.97   63710   0.0   0   0 [kworker/0:2-event intel_uncore_fw_release_timer
   11.99    2831   0.1   0   0 gnome-shell        hrtimer_wakeup               
    8.99    3417   0.1   0   0 evolution          hrtimer_wakeup               
    5.00    1600   0.1   0   0 Xorg               tick_sched_timer             
    5.00   71575   0.3   0   0 top                it_real_fn                   
    4.00    3184   0.7   0   0 gnome-terminal-    tick_sched_timer             
    4.00   59885   0.1   0   0 diodon             hrtimer_wakeup               
    3.00   71575   0.3   0   0 top                tick_sched_timer             
    2.00   72584   0.0   0   0 <unknown>          tick_sched_timer             
    2.00    2831   0.1   0   0 gnome-shell        timerfd_tmrproc              
    1.00   72585   0.0   0   0 sleep              hrtimer_wakeup               
    1.00   66991   0.0   0 -20 [kworker/u9:2-i915 tick_sched_timer             
    1.00     750   0.0   0   0 haveged            hrtimer_wakeup               

that hrtimer_wapeup and tick_sched_timer appear quite often in the top list.
Anything that changed there after 5.2?

Attaching with strace to that WebKitWebProcess:
$ strace -p 10050
strace: Process 10050 attached
restart_syscall(<... resuming interrupted read ...>) = 0
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}], 3, 0) = 0 (Timeout)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}], 3, 0) = 0 (Timeout)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}], 3, 0) = 0 (Timeout)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}], 3, 0) = 0 (Timeout)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}], 3, 14) = 0 (Timeout)

in a very fast "loop"...
Interestingly, printing that out, which is really! fast... doesn't seem
to increase the temperature much.

When I press&hold a key in evolution strace output shows a lot of
these:
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}], 3, 0) = 1 ([{fd=4, revents=POLLIN}])
read(4, "\2\0\0\0\0\0\0\0", 16)         = 8
write(4, "\1\0\0\0\0\0\0\0", 8)         = 8
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(10, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f74c0005ab0, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x55c670eff418, FUTEX_WAKE_PRIVATE, 1) = 1
madvise(0x7f74af5ea000, 4096, MADV_NORMAL) = 0
madvise(0x7f74af5ea000, 4096, MADV_DODUMP) = 0
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(10, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f74c0005ab0, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x55c670eff418, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(10, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f74c0005ab0, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x55c670eff418, FUTEX_WAKE_PRIVATE, 1) = 1
write(10, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f74c0005ab0, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x55c670eff418, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}], 3, 0) = 1 ([{fd=4, revents=POLLIN}])
read(4, "\2\0\0\0\0\0\0\0", 16)         = 8
write(4, "\1\0\0\0\0\0\0\0", 8)         = 8
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
memfd_create("WebKitSharedMemory", MFD_CLOEXEC) = 23
ftruncate(23, 18585600)                 = 0
mmap(NULL, 18585600, PROT_READ|PROT_WRITE, MAP_SHARED, 23, 0) = 0x7f74ae346000
fcntl(23, F_DUPFD_CLOEXEC, 0)           = 18
munmap(0x7f74ae346000, 18585600)        = 0
close(23)                               = 0
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(10, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f74c0005ab0, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x55c670eff418, FUTEX_WAKE_PRIVATE, 1) = 1
madvise(0x7f74af5e9000, 4096, MADV_NORMAL) = 0
madvise(0x7f74af5e9000, 4096, MADV_DODUMP) = 0
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(10, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f74c0005ab0, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x55c670eff418, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(10, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x55c670f5d690, FUTEX_WAIT_PRIVATE, 2, NULL) = -1 EAGAIN (Resource temporarily unavailable)
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 0
futex(0x7f74c0005ab0, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x55c670eff418, FUTEX_WAKE_PRIVATE, 1) = 1
write(10, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f74c0005ab0, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x55c670eff418, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}], 3, 0) = 1 ([{fd=4, revents=POLLIN}])
read(4, "\2\0\0\0\0\0\0\0", 16)         = 8
write(4, "\1\0\0\0\0\0\0\0", 8)         = 8
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
memfd_create("WebKitSharedMemory", MFD_CLOEXEC) = 24
ftruncate(24, 18585600)                 = 0
mmap(NULL, 18585600, PROT_READ|PROT_WRITE, MAP_SHARED, 24, 0) = 0x7f74ae346000
fcntl(24, F_DUPFD_CLOEXEC, 0)           = 18
munmap(0x7f74ae346000, 18585600)        = 0
close(24)                               = 0
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}], 3, 0) = 1 ([{fd=4, revents=POLLIN}])
read(4, "\2\0\0\0\0\0\0\0", 16)         = 8
write(4, "\1\0\0\0\0\0\0\0", 8)         = 8
write(4, "\1\0\0\0\0\0\0\0", 8)         = 8
write(4, "\1\0\0\0\0\0\0\0", 8)         = 8
write(4, "\1\0\0\0\0\0\0\0", 8)         = 8
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(10, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f74c0005ab0, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x55c670eff418, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(10, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f74c0005ab0, FUTEX_WAKE_PRIVATE, 1) = 0
futex(0x55c670eff418, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
write(10, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f74c0005ab0, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x55c670eff418, FUTEX_WAKE_PRIVATE, 1) = 1
write(10, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x55c670f5d690, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f74c0005ab0, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x55c670eff418, FUTEX_WAKE_PRIVATE, 1) = 1
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(3, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}], 3, 0) = 1 ([{fd=4, revents=POLLIN}])
read(4, "\5\0\0\0\0\0\0\0", 16)         = 8
write(4, "\1\0\0\0\0\0\0\0", 8)         = 8
write(15, "\1\0\0\0\0\0\0\0", 8)        = 8
futex(0x7f74d8000b60, FUTEX_WAKE_PRIVATE, 1) = 1
memfd_create("WebKitSharedMemory", MFD_CLOEXEC) = 24
ftruncate(24, 18585600)                 = 0
mmap(NULL, 18585600, PROT_READ|PROT_WRITE, MAP_SHARED, 24, 0) = 0x7f74ae346000
fcntl(24, F_DUPFD_CLOEXEC, 0)           = 18

Not sure if that's normal...


Anyway, back to my needle-in-the-haystack-search:
diodon, which is a small little clipboard helper also shows up in
powertop since a while, not it that much mW, but still much more I'd
have expected from a little tool that does basically nothing.
Attaching to it with strace again reveals a lot of polling:

writev(7, [{iov_base="\203(\3\0\336\5\0\0\2\0\0\0", iov_len=12}, {iov_base=NULL, iov_len=0}, {iov_base="", iov_len=0}], 3) = 12
poll([{fd=7, events=POLLIN}], 1, -1)    = 1 ([{fd=7, revents=POLLIN}])
recvmsg(7, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\1(!T\7\0\0\0\336\5\0\0[\201S\2\0\0]\0\0\0!\1\0\0]\0\0\0!\1"..., iov_len=4096}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 60
poll([{fd=3, events=POLLIN}, {fd=7, events=POLLIN}, {fd=8, events=POLLIN}], 3, 0) = 1 ([{fd=3, revents=POLLIN}])
read(3, "\1\0\0\0\0\0\0\0", 16)         = 8
recvmsg(7, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(7, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=7, events=POLLIN}, {fd=8, events=POLLIN}], 3, 494) = 0 (Timeout)
recvmsg(7, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(7, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=7, events=POLLIN}, {fd=8, events=POLLIN}], 3, 3) = 0 (Timeout)
poll([{fd=7, events=POLLIN|POLLOUT}], 1, -1) = 1 ([{fd=7, revents=POLLOUT}])
writev(7, [{iov_base="\22\0\7\0\2\0\300\4L\2\0\0L\2\0\0\10\0\0\0\1\0\0\0a\1\0\0", iov_len=28}, {iov_base=NULL, iov_len=0}, {iov_base="", iov_len=0}], 3) = 28
poll([{fd=7, events=POLLIN}], 1, -1)    = 1 ([{fd=7, revents=POLLIN}])
recvmsg(7, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\34\0\"T\2\0\300\4L\2\0\0\207f\24\2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", iov_len=4096}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 32
recvmsg(7, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=7, events=POLLIN|POLLOUT}], 1, -1) = 1 ([{fd=7, revents=POLLOUT}])
writev(7, [{iov_base="\27\0\2\0\1\0\0\0", iov_len=8}, {iov_base=NULL, iov_len=0}, {iov_base="", iov_len=0}], 3) = 8
poll([{fd=7, events=POLLIN}], 1, -1)    = 1 ([{fd=7, revents=POLLIN}])
recvmsg(7, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\1\0#T\0\0\0\0\2\0@\2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", iov_len=4096}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 32
poll([{fd=7, events=POLLIN|POLLOUT}], 1, -1) = 1 ([{fd=7, revents=POLLOUT}])
writev(7, [{iov_base="\30\0\6\0\2\0\300\4\1\0\0\0M\2\0\0\230\1\0\0\207f\24\2", iov_len=24}, {iov_base=NULL, iov_len=0}, {iov_base="", iov_len=0}], 3) = 24
recvmsg(7, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
recvmsg(7, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)
poll([{fd=3, events=POLLIN}, {fd=7, events=POLLIN}, {fd=8, events=POLLIN}], 3, 494) = 1 ([{fd=7, revents=POLLIN}])
recvmsg(7, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\34\0$T\2\0\300\4\230\1\0\0\214f\24\2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., iov_len=4096}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 64
recvmsg(7, {msg_namelen=0}, 0)          = -1 EAGAIN (Resource temporarily unavailable)

All this again with 5.5/ips=off/g-c-s.


g) Looking at powertop:
  1.56 W      9,8 ms/s     397,8        Interrupt      PS/2 Touchpad / Keyboard / Mouse
  836 mW      1,6 ms/s     213,9        kWork          dbs_work_handler
  804 mW      2,7 ms/s     205,5        Timer          tick_sched_timer
  594 mW     30,2 ms/s     144,6        Process        [PID 2831] /usr/bin/gnome-shell
  585 mW     35,6 ms/s     140,9        Process        [PID 1600] /usr/lib/xorg/Xorg :0 -seat seat0 -auth /var/run/lightdm/root/:0 -nolisten
(this is during and effectively idly system)

tick_sched_timer and dbs_work_handler appear there quite often at the top.
And they keyboard/mouse/touchpad, too.




7) Conclusions
**************
Well not that many except:
- video acceleration seems not really working
- cinnamon generally worse than gnome-shell-classic (which of course
  doesn't have to be a kernel issue, but it still seems to have gotten
  worse with >5.2 ... and it might be a pointer to what's wrong in the
  kernel
- when the temperature differs more greatly in the measurements, than
  5.2 seems typically much better than 5.5
  and ips=off, too.


My tests are obviously somehow limited. None of them simulates the
"normal" usage, like just switching between windows (well the winmove
tests does to some extent), scrolling up and down in a window and so
on.... and these use cases also greatly increase temperature... not
rarely over 80°C.


Any ideas what could cause all this? Context switches? Spectre&friends
protections that were added after 5.2? Interrupts? Something related to
polling?

Or any ideas what to do in terms of further tests? Other kernel
options? Or other tools (things like eventstat and so on)?


Any help would be appreciated, cause right now my laptop is more of an
oven and it starts to literally burn my legs when I work with it.



Thanks,
Chris.

